{ config, lib, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        # move to profiles.default.extensions
        profiles.default.extensions = with pkgs.vscode-extensions; [
            vscodevim.vim
            visualstudioexptteam.vscodeintellicode
            waderyan.gitblame
        ];
        profiles.default.userSettings = {
            "editor.cursorStyle" = "block";
            "editor.formatOnSave" = true;
            "editor.minimap.enabled" = false;
            "editor.cursorSmoothCaretAnimation" = "on";
            "workbench.layoutControl.enabled" = false;
            "workbench.navigationControl.enabled" = false;
            "chat.commandCenter.enabled" = false;
            "window.commandCenter" = false;
            "editor.autoIndent" = "full";
            "breadcrumbs.enabled" = false;
            "breadcrumbs.filePath" = "last";
            "breadcrumbs.symbolPath" = "on";
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
}
