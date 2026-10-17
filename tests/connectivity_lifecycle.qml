import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    id: test
    property int step: 0
    property int checks: 0

    function check(value, message) {
        if (!value) {
            console.error("CONNECTIVITY_TEST_FAIL " + message);
            Qt.quit();
            return false;
        }
        checks++;
        return true;
    }

    DynamicIslandWindow {
        id: island
        screen: Quickshell.screens[0]
        visible: false
    }

    Timer {
        interval: 600
        running: true
        repeat: true
        onTriggered: {
            if (test.step === 0) {
                const blur = island.BackgroundEffect.blurRegion;
                if (!test.check(blur !== null && blur.regions.length === 6, "native blur covers only the six material surfaces")) return;
                if (!test.check(blur.width === 0 && blur.height === 0, "native blur has no full-window base region")) return;
                const capsule = blur.regions[0].item;
                if (!test.check(island.autoHideProgress > 0.01
                    ? capsule !== null && capsule.width > capsule.height && blur.regions[0].radius > 0
                    : capsule === null, "resting blur follows capsule visibility")) return;
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
                if (!test.check(blur.regions[0].item.radius === 28, "expanded capsule reaches its material radius")) return;
                for (let index = 2; index <= 4; index++) {
                    if (!test.check(blur.regions[index].item !== null && blur.regions[index].radius === 28,
                        "open detail has a rounded native blur region " + index)) return;
                }
                if (!test.check(center.scale === 1, "control center reaches full scale")) return;
                island.toggleControlCenterWindow();
                if (!test.check(!island.wifiConnectivityDetailOpen && !island.bluetoothConnectivityDetailOpen && !island.powerConnectivityDetailOpen, "detail shells close immediately")) return;
                if (!test.check(!center.wifiPanelOpen && !center.bluetoothPanelOpen && !center.powerPanelOpen, "provider clears panel state")) return;
            } else if (test.step === 3) {
                if (!test.check(!island.anyConnectivityDetailMounted && island.controlCenterRef === null, "details and provider unload after animation")) return;
                const blur = island.BackgroundEffect.blurRegion;
                if (!test.check(blur.regions[2].item === null && blur.regions[3].item === null && blur.regions[4].item === null,
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
        }
    }
}
