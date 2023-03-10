cmake_minimum_required(VERSION 3.16)
project(cutie-terminal VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_DEFAULT_MAJOR_VERSION 6)

find_package(Qt6 REQUIRED COMPONENTS Core Widgets Quick Qml)

qt_standard_project_setup()

set(cutie-terminal_SOURCES 
        src/main.cpp
        src/util.cpp
        src/util.h
)

qt_add_resources(APP_RESOURCES 
	${CMAKE_SOURCE_DIR}/src/qml/qml.qrc
	${CMAKE_SOURCE_DIR}/icons/icons.qrc)

qt_add_executable(cutie-terminal ${cutie-terminal_SOURCES} ${APP_RESOURCES})

target_include_directories(cutie-terminal PUBLIC src)

target_link_libraries(cutie-terminal PUBLIC 
    Qt::Core
    Qt::Widgets
    Qt::Quick
    Qt::Qml)

install(TARGETS cutie-terminal RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}")
install(FILES cutie-terminal.desktop DESTINATION "${CMAKE_INSTALL_DATADIR}/applications")
install(FILES cutie-terminal.svg DESTINATION "${CMAKE_INSTALL_DATADIR}/icons/hicolor/scalable/apps")