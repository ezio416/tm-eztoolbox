/*
c 2023-06-03
m 2023-06-06
*/

namespace WhereAmI {
    string CurrentStr() {  // untested: non-COTD cup, ranked, royal
        if (!WAI_enabled) return "disabled";

        string gamemode = GameMode;
        string sequence = SequenceStr();

        bool endRound = sequence == "EndRound";
        bool finish   = sequence == "Finish";
        bool interact = sequence == "UIInteraction";
        bool intro    = sequence == "Intro" ||
                        sequence == "RollingBackgroundIntro";
        bool playing  = sequence == "Playing";
        bool podium   = sequence == "Podium";

        if (gamemode == "TM_COTDQualifications_Online") {
            if (intro)   return "COTD qual - intro";
            if (playing) return "COTD qual - playing";
            if (finish)  return "COTD qual - finish";
            if (podium)  return "COTD qual - podium";
            return "COTD - qual";
        }

        if (gamemode == "TM_KnockoutDaily_Online") {
            if (intro)    return "COTD - intro";
            if (playing)  return "COTD - knockout";
            if (finish)   return "COTD - finish";
            if (interact) return "COTD - between rounds";
            if (podium)   return "COTD - podium";
            return "COTD - loading";
        }

        if (gamemode == "TM_Teams_Matchmaking_Online") {
            if (intro)    return "ranked - intro";
            if (playing)  return "ranked - playing";
            if (finish)   return "ranked - finish";
            if (endRound) return "ranked - between rounds";
            if (podium)   return "ranked - podium";
            return "ranked - loading";
        }

        if (InSkinEditor())
            return "garage - editing skin";

        if (PlayingLocal()) {
            if (!InPlayableMap() && _Script()) return "local - loading";
            if (intro)    return "local - intro";
            if (playing)  return "local - playing";
            if (finish)   return "local - finish";
            if (endRound) return "local - watching replay";
            return "local";
        }

        // could technically be splitscreen, but unlikely
        if (gamemode == "TM_TimeAttack_Online") {
            if (intro)   return "online - intro";
            if (playing) return "online - playing";
            if (finish)  return "online - finish";
            if (podium)  return "online - podium";
            return "online - loading";
        }

        if (_Editor()) {
            if (!_Script()) return "replay editor - editing";
            if (intro)    return "map editor - playtest intro";
            if (playing)  return "map editor - playtesting";
            if (finish)   return "map editor - playtest finish";
            if (endRound) return "map editor - playtest validated";
            return "map editor - editing";
        }

        if (!InPlayableMap()) {
            if (_Script()) return "map editor - loading";
            if (_Map()) return "replay editor - viewing";
            return "menu";
        }

        if (InHotSeat()) {
            if (interact) return "hotseat - waiting";
            if (intro)    return "hotseat - intro";
            if (playing)  return "hotseat - playing";
            if (finish)   return "hotseat - finish";
            return "hotseat";
        }

        return "somewhere lol";
    }

    bool _Editor() {
        if (!WAI_enabled) return false;
        return Globals::App.Editor !is null;
    }

    bool _GameUI() {
        if (!WAI_enabled) return false;
        return InPlayableMap() && UI::IsGameUIVisible();
    }

    bool InCOTD() {
        if (!WAI_enabled) return false;

        string gamemode = GameMode;
        return gamemode == "TM_COTDQualifications_Online" ||
            gamemode == "TM_KnockoutDaily_Online";
    }

    bool InHotSeat() {
        if (!WAI_enabled) return false;
        return GameMode == "TM_HotSeat_Local";
    }

    bool InMapEditor() {
        if (!WAI_enabled) return false;
        return (_Editor() && _Script());
    }

    bool InPlayableMap() {
        if (!WAI_enabled) return false;
        return Globals::Playground !is null;
    }

    bool InReplayEditor() {
        if (!WAI_enabled) return false;
        return (
            (_Editor() && !_Script()) ||
            (_Map() && !InPlayableMap())
        );
    }

    bool InSkinEditor() {
        if (!WAI_enabled) return false;
        return _Editor() && !_Map();
    }

    bool _Map() {
        if (!WAI_enabled) return false;
        return Globals::App.RootMap !is null;
    }

    bool _PlanetUI() {
        if (!WAI_enabled) return false;
        return UI::IsOverlayShown();
    }

    bool PlayingLocal() {
        if (!WAI_enabled) return false;
        return GameMode.Contains("_Local");
    }

    bool PlayingOnline() {
        if (!WAI_enabled) return false;
        return GameMode.Contains("_Online");
    }

    bool _Script() {
        if (!WAI_enabled) return false;
        return Globals::PlaygroundScript !is null;
    }

    string SequenceStr() {
        if (!WAI_enabled) return "disabled";

        switch (Globals::Sequence) {
            case (CGamePlaygroundUIConfig::EUISequence::None):
                return "none";
            case (CGamePlaygroundUIConfig::EUISequence::Playing):
                return "Playing";
            case (CGamePlaygroundUIConfig::EUISequence::Intro):
                return "Intro";
            case (CGamePlaygroundUIConfig::EUISequence::Outro):
                return "Outro";
            case (CGamePlaygroundUIConfig::EUISequence::Podium):
                return "Podium";
            case (CGamePlaygroundUIConfig::EUISequence::CustomMTClip):
                return "CustomMTClip";
            case (CGamePlaygroundUIConfig::EUISequence::EndRound):
                return "EndRound";
            case (CGamePlaygroundUIConfig::EUISequence::PlayersPresentation):
                return "PlayersPresentation";
            case (CGamePlaygroundUIConfig::EUISequence::UIInteraction):
                return "UIInteraction";
            case (CGamePlaygroundUIConfig::EUISequence::RollingBackgroundIntro):
                return "RollingBackgroundIntro";
            case (CGamePlaygroundUIConfig::EUISequence::CustomMTClip_WithUIInteraction):
                return "CustomMTClip_WithUIInteraction";
            case (CGamePlaygroundUIConfig::EUISequence::Finish):
                return "Finish";
            default:
                return "";
        }
    }
}