import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import IslandBackend
import "qml/common"

ShellRoot {
    id: test
    property int step: 0
    property int checks: 0

    FileView {
        id: blurConfig
        path: UserConfig.userConfigPath
        blockWrites: true
    }

    function check(value, message) {
        if (!value) {
            console.error("CONNECTIVITY_TEST_FAIL " + message);
            Qt.quit();
            return false;
        }
        checks++;
        return true;
    }

    function checkBlurBounds(region, message) {
        const surface = region.surface;
        const start = surface.mapToItem(null, 0, 0);
        const end = surface.mapToItem(null, surface.width, surface.height);
        return check(region.width > 0 && region.height > 0
            && region.x > start.x && region.y > start.y
            && region.x + region.width < end.x && region.y + region.height < end.y
            && region.x - start.x < 4 && region.y - start.y < 4
            && end.x - region.x - region.width < 4
            && end.y - region.y - region.height < 4, message);
    }

    // Evaluate the actual rectangular region tree, independently of the corner
    // formula. A bounds-only check misses ellipse pixels leaking at the bottom.
    function containsBlurPixel(region, x, y) {
        let inside = x >= region.x && x < region.x + region.width
            && y >= region.y && y < region.y + region.height;
        for (const child of region.regions) {
            const covered = containsBlurPixel(child, x, y);
            inside = child.intersection === Intersection.Subtract
                ? inside && !covered : inside || covered;
        }
        return inside;
    }

    function checkBlurCorners(region) {
        if (!check(region.radius === 0 && region.regions.length === region.roundedRadius,
            "blur uses rectangular strips instead of the asymmetric native ellipse")) return false;
        const radius = region.roundedRadius;
        for (let row = 0; row < radius; row++) {
            let previous = false;
            for (let column = 0; column <= radius; column++) {
                const left = region.x + column;
                const right = region.x + region.width - column - 1;
                const top = region.y + row;
                const bottom = region.y + region.height - row - 1;
                const covered = containsBlurPixel(region, left, top);
                if (covered !== containsBlurPixel(region, right, top)
                        || covered !== containsBlurPixel(region, left, bottom)
                        || covered !== containsBlurPixel(region, right, bottom))
                    return check(false, "all four blur corners have identical coverage");
                // The outermost point of a covered cell must lie in the arc.
                if (covered && Math.hypot(radius - column, radius - row) > radius + 0.0001)
                    return check(false, "blur pixels never spill outside the inset curve");
                if (previous && !covered)
                    return check(false, "blur rows have no gaps");
                previous = covered;
            }
            if (!previous) return check(false, "blur covers the full interior of every row");
        }
        return check(containsBlurPixel(region, region.x + Math.floor(region.width / 2), region.y)
            && containsBlurPixel(region, region.x + Math.floor(region.width / 2), region.y + region.height - 1),
            "top and bottom retain the same blur extent");
    }

    Item {
        id: transformedParent
        x: 10.25; y: 20.75
        width: 600; height: 500
        Item {
            id: fractionalSurface
            x: 3.375; y: 5.125
            width: 420.5; height: 352.75
        }
    }

    InsetBlurRegion {
        id: fractionalBlur
        surface: fractionalSurface
        surfaceRadius: 28
        active: true
    }

    DynamicIslandWindow {
        id: island
        screen: Quickshell.screens[0]
        visible: false
    }

    Timer {
        id: lifecycleTimer
        interval: 600
        running: true
        repeat: true
        onTriggered: {
            if (test.step === 0) {
                // Exercise both animation scaling and fractional output scales
                // with a transformed ancestor and noninteger surface bounds.
                for (const scale of [0.96, 1, 4 / 3, 1.5, 2]) {
                    transformedParent.scale = scale;
                    transformedParent.x += 0.37;
                    transformedParent.y += 0.29;
                    fractionalBlur.updateGeometry();
                    if (!test.checkBlurBounds(fractionalBlur, "fractional blur stays inside its material at scale " + scale)) return;
                    if (!test.checkBlurCorners(fractionalBlur)) return;
                }
                // An odd-sized capsule must clamp its radius without leaving
                // stale strips when transitioning from a large detail panel.
                fractionalSurface.width = 138;
                fractionalSurface.height = 35;
                fractionalBlur.surfaceRadius = 17.5;
                transformedParent.scale = 1;
                fractionalBlur.updateGeometry();
                if (!test.checkBlurCorners(fractionalBlur)) return;
                fractionalBlur.active = false;
                fractionalBlur.updateGeometry();
                if (!test.check(fractionalBlur.width === 0 && fractionalBlur.height === 0 && fractionalBlur.regions.length === 0,
                    "inactive blur has no residual area")) return;
                const blur = island.BackgroundEffect.blurRegion;
                if (!test.check(blur !== null && blur.regions.length === 6, "native blur covers only the six material surfaces")) return;
                if (!test.check(blur.width === 0 && blur.height === 0, "native blur has no full-window base region")) return;
                const capsule = blur.regions[0].surface;
                if (!test.check(island.autoHideProgress > 0.01
                    ? capsule !== null && capsule.width > capsule.height && blur.regions[0].roundedRadius > 0
                    : !blur.regions[0].active, "resting blur follows capsule visibility")) return;
                island.toggleControlCenterWindow();
            } else if (test.step === 1) {
                if (!test.check(island.controlCenterRef !== null, "control center loaded")) return;
                const center = island.controlCenterRef;
                if (!test.check(center.wifiSupported && center.wifiEnabled && center.wifiCurrentSsid === "Home", "Wi-Fi state reaches control center")) return;
                center.setConnectivityPanelOpen("wifi", true);
                center.setConnectivityPanelOpen("bluetooth", true);
                center.setConnectivityPanelOpen("power", true);
                if (!test.check(island.wifiConnectivityDetailOpen && island.bluetoothConnectivityDetailOpen && island.powerConnectivityDetailOpen, "detail shells open")) return;
            } else if (test.step === 2) {
                const center = island.controlCenterRef;
                const blur = island.BackgroundEffect.blurRegion;
                if (!test.check(blur.regions[0].surface.radius === 28 && blur.regions[0].roundedRadius < 28, "expanded capsule reaches its material radius")) return;
                if (!test.checkBlurBounds(blur.regions[0], "expanded blur stays inside the capsule after morphing")) return;
                if (!test.checkBlurCorners(blur.regions[0])) return;
                for (let index = 2; index <= 4; index++) {
                    if (!test.check(blur.regions[index].active && blur.regions[index].width > 0 && blur.regions[index].roundedRadius > 0 && blur.regions[index].roundedRadius < 28,
                        "open detail has a rounded native blur region " + index)) return;
                    if (!test.checkBlurBounds(blur.regions[index], "detail blur follows its ancestor transform " + index)) return;
                }
                if (!test.check(center.scale === 1, "control center reaches full scale")) return;
                blurConfig.setText('{"islandBlurEnabled":false}');
                UserConfig.reload();
                if (!test.check(!UserConfig.islandBlurEnabled && island.BackgroundEffect.blurRegion === null,
                    "disabling blur removes the entire effect including open detail panels")) return;
                if (!test.check(UserConfig.islandBackgroundOpacity === 60,
                    "blur preference does not change default opacity")) return;
                blurConfig.setText('{"islandBlurEnabled":true}');
                UserConfig.reload();
                if (!test.check(UserConfig.islandBlurEnabled && island.BackgroundEffect.blurRegion === blur,
                    "reenabling blur restores visible regions without reopening panels")) return;
                island.toggleControlCenterWindow();
                if (!test.check(!island.wifiConnectivityDetailOpen && !island.bluetoothConnectivityDetailOpen && !island.powerConnectivityDetailOpen, "detail shells close immediately")) return;
                if (!test.check(!center.wifiPanelOpen && !center.bluetoothPanelOpen && !center.powerPanelOpen, "provider clears panel state")) return;
            } else if (test.step === 3) {
                if (!test.check(!island.anyConnectivityDetailMounted && island.controlCenterRef === null, "details and provider unload after animation")) return;
                const blur = island.BackgroundEffect.blurRegion;
                if (!test.check(blur.regions[2].width === 0 && blur.regions[3].width === 0 && blur.regions[4].width === 0,
                    "closed details leave no invisible blur behind")) return;
                island.toggleControlCenterWindow();
            } else if (test.step === 4) {
                if (!test.check(island.controlCenterRef !== null && !island.controlCenterRef.anyConnectivityPanelOpen && !island.controlCenterRef.powerPanelOpen, "reopening has no stale details")) return;
                island.controlCenterRef.setConnectivityPanelOpen("wifi", true);
                island.controlCenterRef.setConnectivityPanelOpen("bluetooth", true);
                island.toggleNotificationCenterWindow();
                if (!test.check(!island.wifiConnectivityDetailOpen && !island.bluetoothConnectivityDetailOpen, "switching page closes details")) return;
            } else if (test.step === 5) {
                if (!test.check(!island.anyConnectivityDetailMounted && island.controlCenterRef === null, "page switch releases details")) return;
                island.toggleControlCenterWindow();
            } else if (test.step === 6) {
                island.controlCenterRef.setConnectivityPanelOpen("wifi", true);
                island.controlCenterRef.setConnectivityPanelOpen("bluetooth", true);
                // Reproduce a failing backend cleanup independently of the
                // singleton fix: the window must still close both shells.
                island.controlCenterRef.injectCleanupFailure = true;
                island.toggleControlCenterWindow();
                if (!test.check(!island.wifiConnectivityDetailOpen && !island.bluetoothConnectivityDetailOpen, "cleanup failure cannot leave details open")) return;
            } else if (test.step === 7) {
                if (!test.check(!island.anyConnectivityDetailMounted && island.controlCenterRef === null, "cleanup failure cannot retain provider")) return;
                console.log("CONNECTIVITY_TEST_PASS " + test.checks);
                Qt.quit();
            }
            test.step++;
            // Geometry checks are synchronous; allow a full interval for D-Bus
            // updates and closing animations after each action, not mid-check.
            lifecycleTimer.restart();
        }
    }
}
