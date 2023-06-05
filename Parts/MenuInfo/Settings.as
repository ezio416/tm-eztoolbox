/*
c 2023-06-04
m 2023-06-04
*/

namespace MenuInfo {
    [Setting category="MenuInfo" name="Text color"]
    string MI_colorCode = "FFF";

    [Setting category="MenuInfo" name="Text position" min=10 max=3840]
    uint MI_textPosition = 10;

    [Setting category="MenuInfo" name="Spacing" min=1 max=100]
    uint MI_spacingCount = 5;

    [Setting category="MenuInfo" name="OnlineChecker"]
    bool MI_OnlineChecker = true;  // false for release

    [Setting category="MenuInfo" name="WhereAmI"]
    bool MI_WhereAmI = true;  // false for release

    [Setting category="MenuInfo" name="Server ping" description="only shown when on a server, duh"]
    bool MI_ping = true;

    [Setting category="MenuInfo" name="COTD countdown"]
    bool MI_COTD = true;

    [Setting category="MenuInfo" name="FPS counter"]
    bool MI_FPS = true;

    [Setting category="MenuInfo" name="Clock"]
    bool MI_clock = true;
}