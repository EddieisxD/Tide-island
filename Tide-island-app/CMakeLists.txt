cmake_minimum_required(VERSION 3.16)
project(tide-island-config-app LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

include(GNUInstallDirs)

find_package(Qt6 REQUIRED COMPONENTS
    Gui
    Qml
    Quick
    QuickControls2
    QuickDialogs2
    Test
)

qt_add_executable(tide-island-config-app
    main.cpp
    backend.hpp
    backend.cpp
    resources.qrc
)

target_link_libraries(tide-island-config-app PRIVATE
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::QuickDialogs2
)

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/tests/shortcut_config_tests.cpp")
    add_executable(tide_island_shortcut_config_tests
        tests/shortcut_config_tests.cpp
        backend.hpp
        backend.cpp
    )

    target_include_directories(tide_island_shortcut_config_tests PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
    )

    target_link_libraries(tide_island_shortcut_config_tests PRIVATE
        Qt6::Gui
        Qt6::Test
    )

    add_test(NAME tide_island_shortcut_config COMMAND tide_island_shortcut_config_tests)
endif()

set_source_files_properties(Theme.qml ConfigStore.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

# Share the real lock-screen view with its settings preview; keep it independent
# of Quickshell so this application can also render it offscreen.
set(LOCK_SCREEN_VIEW_FILES
    ../qml/lockscreen/LockScreenView.qml
    ../qml/lockscreen/LockCard.qml
    ../qml/lockscreen/LockGlyph.qml
    ../qml/lockscreen/LockAction.qml
    ../qml/lockscreen/LockScreenTransition.qml
    ../qml/lockscreen/LockLayoutHandle.qml
)
foreach(lock_file IN LISTS LOCK_SCREEN_VIEW_FILES)
    get_filename_component(lock_name "${lock_file}" NAME)
    set_source_files_properties("${lock_file}" PROPERTIES QT_RESOURCE_ALIAS "${lock_name}")
endforeach()

qt_add_qml_module(tide-island-config-app
    URI TideIsland
    VERSION 1.0
    RESOURCE_PREFIX /qt/qml

    # Use the shell's existing material and control tokens in the native preview.
    SOURCES
        ../backend/StyleTokensBackend.h
        ../backend/StyleTokensBackend.cpp

    QML_FILES
        Main.qml
        Theme.qml
        ConfigStore.qml
        PagePanel.qml
        ConfigTextField.qml
        HiddenPathDialog.qml
        General.qml
        CustomPage.qml
        Wallpaper.qml
        WallpaperSettings.qml
        TlpSettings.qml
        WeatherSettings.qml
        FontSettings.qml
        Interaction.qml
        Shortcut.qml
        ApplicationLauncherSettings.qml
        LockScreenSettings.qml
        ${LOCK_SCREEN_VIEW_FILES}
)

target_include_directories(tide-island-config-app PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../backend)

install(TARGETS tide-island-config-app
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/TideIsland
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/qt6/qml
    PATTERN "*.qrc" EXCLUDE
)

configure_file(tide-island-config.desktop ${CMAKE_CURRENT_BINARY_DIR}/tide-island-config.desktop @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/tide-island-config.desktop
    DESTINATION ${CMAKE_INSTALL_DATADIR}/applications
)

add_test(NAME tide_island_config_qml
    COMMAND tide-island-config-app --validate-qml
)
set_tests_properties(tide_island_config_qml PROPERTIES
    ENVIRONMENT "QT_QPA_PLATFORM=offscreen"
)
