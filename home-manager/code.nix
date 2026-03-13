{ config, lib, pkgs, ... }:

let
    openjdk_pkg = pkgs.jdk21;
in
{
    programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
            vscodevim.vim
            visualstudioexptteam.vscodeintellicode
            waderyan.gitblame
            # nix
            bbenoist.nix
            # python
            ms-python.python
            ms-python.debugpy
            ms-python.vscode-pylance
            charliermarsh.ruff
            # js / webdev
            bradlc.vscode-tailwindcss
            # java
            redhat.java
            vscjava.vscode-java-pack
        ];
        profiles.default.userSettings = {
            "editor.cursorStyle" = "block";
            "editor.formatOnSave" = true;
            "editor.minimap.enabled" = false;
            "editor.cursorSmoothCaretAnimation" = "on";
            "workbench.layoutControl.enabled" = false;
            "workbench.navigationControl.enabled" = false;
            "window.commandCenter" = false;
            "editor.autoIndent" = "full";
            "breadcrumbs.enabled" = false;
            "breadcrumbs.filePath" = "last";
            "breadcrumbs.symbolPath" = "on";
            "chat.commandCenter.enabled" = false;
            "chat.agent.enabled" = false;

            # python
            "[python]" = {
                "editor.formatOnSave" = false;
                "editor.defaultFormatter" = "charliermarsh.ruff";
            };
            "python.languageServer" = "Pylance";
            "python.analysis.typeCheckingMode" = "basic";

            "files.exclude" = {
                # python
                "**/__pycache__" = true;
                "**/*.pyc" = true;
            };
            "ruff.nativeServer" = "auto";

            "java.jdt.ls.java.home" = "${openjdk_pkg}/lib/openjdk";
        };
        # move to profiles.default.keybindings
        profiles.default.keybindings = [
            # lsp hover
            {
                key = "shift+k";
                command = "editor.action.showDefinitionPreviewHover";
                when = "editorTextFocus && vim.active && vim.use<C-g> && !inDebugRepl && vim.mode != 'Insert'";
            }
            # extensions
            {
                key = "ctrl+e";
                command = "workbench.view.extensions";
                when = "viewContainer.workbench.view.extensions.enabled";
            }
            # quickfix
            {
                key = "alt+enter";
                command = "editor.action.quickFix";
                when = "editorHasCodeActionsProvider && textInputFocus && !editorReadonly";
            }
            # file explorer
            {
                key = "ctrl+t";
                command = "workbench.view.explorer";
                when = "viewContainer.workbench.view.explorer.enabled";
            }
            {
                key = "ctrl+b";
                command = "workbench.action.toggleSidebarVisibility";
                when = "viewContainer.workbench.view.explorer.enabled";
            }
            # file explorer actions
            {
                key = "shift+alt+a";
                command = "workbench.files.action.createFileFromExplorer";
            }
            {
                key = "shift+alt+f";
                command = "workbench.files.action.createFolderFromExplorer";
            }
            # file search
            {
                key = "ctrl+p";
                command = "workbench.action.quickOpen";
            }
            # terminal view toggle
            {
                key = "ctrl+j";
                # command = "workbench.action.terminal.focus";
                command = "workbench.action.terminal.toggleTerminal";
            }
            # Open folder
            {
                key = "ctrl+shift+o";
                command = "workbench.action.files.openLocalFolder";
            }
        ];
    };
    programs.ruff = {
        enable = true;
        settings = {
            line-length = 100;
        };
    };
}
