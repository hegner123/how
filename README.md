# How
Neovim Plugin to create and manage a reference for vim commands.

### Usage
:HowAdd search "%s@search@replace@g"
:HowAdd
opens a buffer to declare multiple references in the format:
key "value";
key "value";
and creates them on save.
:How search
returns "%s@search@replace@g"
:How
returns all saved references
