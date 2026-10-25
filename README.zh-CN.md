<h1 align="center">Tide Island</h1>

<p align="center">
  <b>一个为 Hyprland 和 niri 打造的流畅、轻量且灵活的交互式灵动岛。</b>
</p>

<p align="center">
  <sub>
    <a href="./README.md">English</a>
     · 
    <a href="./README.zh-CN.md">简体中文</a>
  </sub>
</p>

<p align="center">
  <a href="https://github.com/enhaoswen/Tide-island/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/enhaoswen/Tide-island?style=flat-square&color=8aadf4"></a>
  <a href="https://github.com/enhaoswen/Tide-island/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/enhaoswen/Tide-island?style=flat-square&color=8aadf4"></a>
  <a href="https://aur.archlinux.org/packages/tide-island"><img alt="AUR package" src="https://img.shields.io/aur/version/tide-island?style=flat-square&label=AUR&color=8aadf4"></a>
  <a href="https://deepwiki.com/enhaoswen/Tide-island"><img alt="Ask DeepWiki" src="https://deepwiki.com/badge.svg"></a>
  <img alt="Hyprland" src="https://img.shields.io/badge/Hyprland-111111?style=flat-square&color=8aadf4">
  <img alt="niri" src="https://img.shields.io/badge/niri-111111?style=flat-square&color=8aadf4">
  <img alt="C++ + Qt" src="https://img.shields.io/badge/C%2B%2B%20%2B%20Qt-111111?style=flat-square&color=8aadf4">
</p>

<p align="center">
  <a href="#预览">预览</a>
  ·
  <a href="#功能">功能</a>
  ·
  <a href="#安装">安装</a>
  ·
  <a href="#配置">配置</a>
  ·
  <a href="#常用命令">常用命令</a>
  ·
  <a href="#清除通知">通知中心</a>
</p>

---

## 关于 Tide Island

Tide Island 是一款面向 Hyprland 和 niri 的小型桌面组件，采用类似灵动岛的设计。

平时没有什么动静时，它就安静地待在角落，不会碍事。需要查看信息时，它会展开成一个面板，让你查看歌词、切换工作区、调整系统设置、查看通知，或放置一些自定义内容。

它基于 Quickshell、QML 和 C++/Qt 6 构建。开发时的大部分精力都花在了让动画尽可能流畅、交互足够跟手，同时控制好资源占用上。谈不上有什么特别，但希望它用起来足够舒服。

> [!WARNING]
> **Tide Island 已迁移至新的仓库。**
>
> 当前版本仍可正常使用，但已不再积极维护。
>
> 新版本正在开发中，目前**尚未完成**。
>
> 最新开发进展请前往 **[Tide Island — 新仓库](https://github.com/enhaoswen/Tide-Island-New)**。


<br>

## 预览

### Tide Island

<table>
  <tr>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/mp.png" width="100%" alt="音乐播放器" />
    </td>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/msg.png" width="100%" alt="消息预览" />
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/timer.png" width="100%" alt="计时器" />
    </td>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/wallpaper%20switcher.png" width="100%" alt="壁纸切换器" />
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/cc_2.png" width="100%" alt="控制中心" />
    </td>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/Workspace overview_2.png" width="100%" alt="工作区总览" />
    </td>
  </tr>
  <tr>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/weather.png" width="100%" alt="天气预报" />
    </td>
    <td width="50%">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/calendar.png" width="100%" alt="日历" />
    </td>
  </tr>
  <tr>
    <td colspan="2">
      <img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/clipboard.png" width="100%" alt="剪贴板历史" />
    </td>
  </tr>
</table>

### 配置应用

<img src="https://raw.githubusercontent.com/enhaoswen/Tide-island/display/Preview/config_app.png" width = "90%">
<br>

## 功能

- 时钟
- 音乐播放器
- 控制中心
- 计时器
- 歌词显示
- 应用启动器
- 文件中转站
- 剪贴板历史管理器
- 天气预报
- 日历
- 壁纸切换器
- 工作区总览
- 自定义页面
- 通知中心
- 电源菜单

剪贴板历史需要安装 `cliphist` 和 `wl-clipboard`。Tide Island 运行时会自动监听并记录新复制的内容。
点击日历中的日期即可编辑便签。写过便签的日期会显示小白点，内容会自动保存。

### 系统反馈

- 音量变化
- 亮度变化
- 电池充电 / 放电
- 工作区切换
- 媒体播放（可选）
- 系统通知

### 自定义页面

- 时间
- 日期
- 电池
- 音量
- CPU 占用
- 当前工作区
- 内存占用
- 亮度
- Cava
- 存储占用
- 天气

### 合成器支持

- Hyprland：提供完整的现有体验，包括 Tide 的工作区总览、工作区动画、快捷键，以及通过 `hyprsunset` 实现的 Night Light（夜间色温调节）。
- niri：支持灵动岛视图、基于当前聚焦输出的 IPC 命令、工作区切换提示、niri 原生总览、通过 `~/.config/tide-island/niri-shortcuts.kdl` 配置快捷键，以及通过 `gammastep` 实现的 Night Light（夜间色温调节）。
- Tide 会优先检查 `TIDE_ISLAND_COMPOSITOR`，随后检查 `$XDG_CURRENT_DESKTOP`。只有在无法通过桌面环境确定合成器时，才会检查 `$NIRI_SOCKET`，最后回退到 Hyprland。这样可以避免继承的合成器套接字导致误判。

<br>

## 安装

### Arch Linux

从 AUR 安装：

```bash
yay -S tide-island
```

### 其他 Linux 发行版

从[最新的 GitHub Release](https://github.com/enhaoswen/Tide-island/releases/latest)下载源码包和校验文件：

```bash
curl -fLO https://github.com/enhaoswen/Tide-island/releases/latest/download/tide-island-source.tar.xz
curl -fLO https://github.com/enhaoswen/Tide-island/releases/latest/download/SHA256SUMS
sha256sum --check SHA256SUMS
tar -xf tide-island-source.tar.xz
cd Tide-island-*
./install.sh
```

安装器会将 Tide Island 安装到 `/usr`，并可在以下发行版上自动安装依赖：

- 使用 `apt` 的 Debian、Ubuntu 及其衍生发行版
- 使用 `dnf` 的 Fedora、RHEL 及其衍生发行版
- 使用 `zypper` 的 openSUSE

对于其他发行版，请手动安装依赖，然后运行：

```bash
./install.sh --skip-deps
```

如果 `/usr/bin/quickshell` 存在，安装器会直接使用它；否则，安装器会构建当前发行版锁定、经过验证且与其兼容的 Quickshell 版本。需要 Qt 6.6 或更高版本。

此源码安装器适用于 `/usr` 可写的常规 Linux 系统。NixOS、Fedora Silverblue 等声明式或不可变系统应改用原生软件包，或在可写的开发容器中安装。

常用安装选项：

| 选项 | 说明 |
| --- | --- |
| `./install.sh --no-service` | 安装 Tide Island，但不启用或启动 systemd 用户服务。 |
| `./install.sh --skip-quickshell` | 跳过从源码构建 Quickshell，使用现有的 `/usr/bin/quickshell`；如果该文件不存在，安装会报错并停止。 |
| `./install.sh --force-build-quickshell` | 即使系统中已安装 Quickshell，也重新构建并安装项目指定的 Quickshell 版本。 |
| `./install.sh --uninstall` | 移除由源码安装器安装的 Tide Island 文件；已安装的依赖和 Quickshell 会保留。 |

<br>

## 启动 Tide Island

Tide Island 提供 systemd 用户服务。

立即启用并启动（推荐）：

```bash
systemctl --user enable --now tide-island.service
```

如果希望手动管理自启动，请在 `hyprland.conf` 中添加：

```conf
exec-once = tide-island
```

或者在 `hyprland.lua` 中添加：

```lua
hl.exec_once("tide-island")
```

如果已启用 systemd 服务，则无需再添加 `exec-once`。

<br>

## 配置

在任意应用启动器中搜索 `Tide Island Settings`，或者运行：

```bash
tide-island-config-app
```

- **快捷键**：配置工作区总览、应用启动器、音乐播放器、通知中心、控制中心、剪贴板历史管理器（默认 `Super + V`）、天气（默认 `Super + E`）以及日历（默认 `Super + K`）的快捷键。
- **交互**：配置灵动岛胶囊的鼠标点击动作（支持为音乐播放器、控制中心、剪贴板历史自定义左键、中键、右键映射）。
- **天气**：配置自动定位或自定义城市名称、温度单位（°C 或 °F）以及刷新间隔。
- **日历**：快速月历视图，提供周数与相对日期显示。可在控制中心点击日期、使用 `Super + K` 快捷键打开，支持鼠标滚轮与方向键切换月份、`Home` 键返回今天、`Esc` 快速关闭。


### 锁屏

在设置应用左侧打开 **Lock screen**，可实时预览双列卡片（Dashboard）布局，并拖动自定义控件位置。头像、名字、时间、日期、音乐、天气和电量可以独立开关；支持自选头像与锁屏壁纸、12/24 小时制、秒数、底部留言，以及背景模糊、暗度、卡片透明度和圆角调整。没有自选壁纸时使用 Tide Island 的壁纸，图片不可用时显示渐变背景。

点击 **Lock now**、控制中心电源菜单中的锁屏按钮，或在 **Shortcut** 页配置锁屏快捷键（默认 `Super + L`，需按现有快捷键流程应用）。运行中的灵动岛也支持以下命令：

```bash
# 直接打开锁屏设置页
tide-island-config-app --lock-screen

# 锁定会话
quickshell ipc --any-display -p /usr/share/tide-island call tide lockScreen
```

锁屏通过 Wayland `ext-session-lock-v1` 覆盖所有显示器，使用系统 PAM `login` 服务验证当前用户密码，只有验证成功才会解锁。密码不会写入配置文件，设置预览使用示例数据且不进行认证。需要可用的 `Quickshell.Services.Pam` 模块和系统 `/etc/pam.d/login`。锁定期间暂停自动 QML 热重载；请先解锁再停止或重启灵动岛，因为合成器会在锁屏进程退出后继续保持锁定。

进入时壁纸渐入、卡片依次浮现；系统验证成功后，卡片淡出、背景恢复清晰，再释放会话锁。多显示器共用同一条动画时间线。设置页的 **Replay** 按钮可以预览进入和退出动画。

开启 **Layout → Custom positions**，即可在预览中拖动用户信息、时间、密码框、天气和音乐卡片。电量显示在用户信息卡片的最右侧，随头像和名字一起移动。位置自动保存，按屏幕比例应用，并在不同分辨率下保持卡片完整可见。**Reset positions** 恢复默认位置；选择 Dashboard 会关闭自定义位置并保留已有记录。编辑边框和拖动操作只在设置预览中出现。

音乐卡片复用灵动岛的 MPRIS 播放器，包含上一首、播放/暂停、下一首和收藏。收藏沿用已有的 Spotify 连接，不支持的操作会禁用。天气沿用 General 中的位置、单位和刷新设置，缓存数据会标注。外观配置保存在 `userconfig.json` 的 `lockScreen` 对象中。目前提供手动锁屏，空闲或休眠自动化工具可调用上面的 IPC 命令。

布局参考 [Caelestia](https://github.com/caelestia-dots/shell)；模糊背景与组件布局最初参考了 [Hyprlock-Dots](https://github.com/mahaveergurjar/Hyprlock-Dots)。材质和控件沿用 Tide Island 原有的苹果风格：深灰磨砂、细描边和白色播放按钮，锁屏与设置预览使用同一份样式定义。未打包参考项目的图片或源码。

### 磨砂玻璃外观

灵动岛、网络与蓝牙详情、日历便笺使用统一的半透明材质。在设置的
**General → Island Appearance → Background Transparency** 中调整岛的背景不透明度，
设为 100 可使用实色背景。**Background Blur** 开关统一控制岛和所有详情面板的模糊，
修改后立即生效。默认不透明度为 **60**，模糊**开启**（`islandBlurEnabled: true`）。
设置窗口支持浅色和深色外观。

原生背景模糊使用 Quickshell 0.3+ 的
[BackgroundEffect](https://quickshell.org/docs/v0.3.0/types/Quickshell.Wayland/BackgroundEffect/)，
需要合成器支持 `ext-background-effect-v1` 协议。模糊区域会跟随可见面板的圆角和动画，
面板关闭后移除；不支持该协议时显示半透明着色背景。Layer-shell 命名空间为 `tide-island`。

模糊区域向内对齐，外沿保留浅色细描边与抗锯齿。Tide 已自行处理展开动画；
Hyprland 的窗口层动画可能再次缩放整个面板，使文字与模糊轮廓错位。使用 Lua 配置时，
可仅为 Tide 关闭这层动画：

```lua
hl.layer_rule({
    name = "tide-island-native-morph",
    match = { namespace = "^tide-island$" },
    no_anim = true,
})
```

## Spotify 收藏

音乐播放器支持把当前歌曲加入／移出 Spotify 的「已喜欢歌曲」，并同步客户端中的收藏状态。
使用本机 Spotify 桌面客户端和 [Spicetify](https://spicetify.app/docs/getting-started)，无需 Spotify 开发者应用、API Key、浏览器自动化或集中服务器，也没有开发者应用的用户白名单限制。
收藏使用当前登录账号的普通曲库权限，无需为此购买 Premium。

安装／更新 Tide Island 后，先打开 Spotify 并登录，再安装 Spicetify，然后以桌面用户身份运行：

```bash
tide-island-spotify-setup
```

这个命令安装配套扩展，自动选择首次备份、应用已有备份或迁移旧版备份，过程中 Spotify 可能重启。
在源码目录也可以运行 `python3 scripts/spotify-setup.py`。安装脚本只添加 Tide Island 扩展，保留已有主题和其他扩展。

展开灵动岛播放器，右侧心形按钮显示当前歌曲的收藏状态；实心表示已收藏。
扩展未连接、歌曲状态未知或正在更新时，按钮不可操作。切歌时旧请求不会修改新歌的显示状态。

本机桥接仅监听 `127.0.0.1`，默认端口 `8976`。配置在 `$XDG_CONFIG_HOME/tide-island/spotify-bridge.json`（默认 `~/.config/tide-island/spotify-bridge.json`），其中的令牌只用于本机连接认证，扩展不会向 Tide Island 发送 Spotify 密码、Cookie 或访问令牌。

```bash
# 如果默认端口被占用
tide-island-spotify-setup --port 9898

# 仅生成配置和扩展，稍后手动应用
tide-island-spotify-setup --no-apply

# 移除配套扩展和本机桥接配置
tide-island-spotify-setup --remove

# 检查连接、歌曲和收藏状态（不输出账号凭据）
quickshell ipc call tide spotifyFavoritesStatus
```

Spotify 更新后如收藏失效，先更新 Spicetify，再重新运行安装命令。此功能依赖兼容的桌面客户端与 Spicetify，目前仅支持 Spotify 在线歌曲；本地文件、播客和其他 MPRIS 播放器不显示收藏按钮。
新增构建／运行依赖为 Qt WebSockets；Arch 包和源码安装脚本已包含此依赖。

## 常用命令

#### 修改配置后重启：

```bash
systemctl --user restart tide-island
```

#### 停止 Tide Island：

```bash
systemctl --user stop tide-island
```

#### 查看日志：

```bash
journalctl --user -u tide-island -f
```

#### IPC 命令

可以通过 `quickshell ipc call` 远程控制 Tide Island：

| 命令 | 操作 |
| --- | --- |
| `quickshell ipc call tide toggleCalendar` | 打开或关闭日历视图 |
| `quickshell ipc call tide openCalendar` | 打开日历视图 |
| `quickshell ipc call tide closeCalendar` | 关闭日历视图 |
| `quickshell ipc call tide toggleWeather` | 打开或关闭天气视图 |
| `quickshell ipc call tide openWeather` | 打开天气视图 |
| `quickshell ipc call tide closeWeather` | 关闭天气视图 |
| `quickshell ipc call weather refresh` | 立即刷新天气数据 |
| `quickshell ipc call tide toggleClipboard` | 打开或关闭剪贴板历史 |
| `quickshell ipc call tide openClipboard` | 打开剪贴板历史 |
| `quickshell ipc call tide closeClipboard` | 关闭剪贴板历史 |
| `quickshell ipc call tide toggleNotificationCenter` | 打开或关闭通知中心 |
| `quickshell ipc call tide openNotificationCenter` | 打开通知中心 |
| `quickshell ipc call tide closeNotificationCenter` | 关闭通知中心 |
| `quickshell ipc call tide toggleApplicationLauncher` | 打开或关闭应用启动器 |

<br>

### 清除通知

点击通知卡片上的 × 按钮可以清除单条通知。使用 **全部清除** 可以一次清除所有通知。

## 贡献

欢迎提交 issue、bug 报告、设计建议和 pull request。

## 致谢

感谢：

- [@end-4](https://github.com/end-4) 提供工作区总览的设计灵感
- [@gozhuimeng](https://github.com/gozhuimeng) 改进歌词后端
- [@LatifKovani](https://github.com/LatifKovani) 带来重要改进

## 社区

- Discord: https://discord.gg/Rcj3uPtKwD
- Email: enhaoswen@gmail.com


## 收藏

<a href="https://star-history.com/#enhaoswen/Tide-island&Date">
  <picture>
    <source
      media="(prefers-color-scheme: dark)"
      srcset="https://api.star-history.com/svg?repos=enhaoswen/Tide-island&type=Date&theme=dark"
    />
    <source
      media="(prefers-color-scheme: light)"
      srcset="https://api.star-history.com/svg?repos=enhaoswen/Tide-island&type=Date"
    />
    <img
      alt="Star History Chart"
      src="https://api.star-history.com/svg?repos=enhaoswen/Tide-island&type=Date"
    />
  </picture>
</a>

---

<p align="center">
  <sub>
    为喜欢安静、实用桌面的 Wayland 用户而作。
  </sub>
</p>
