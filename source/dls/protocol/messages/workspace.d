module dls.protocol.messages.workspace;

import dls.protocol.configuration;
import dls.protocol.handlers;
import dls.protocol.interfaces;
import dls.tools.code_completer;
import dls.util.json;
import dls.util.uri;
import std.algorithm;
import std.json;
import std.path;

void didChangeConfiguration(DidChangeConfigurationParams params)
{
    if ("d" in params.settings && "dls" in params.settings["d"])
    {
        Configuration.set(convertFromJSON!Configuration(params.settings["d"]["dls"]));
    }
}

void didChangeWatchedFiles(DidChangeWatchedFilesParams params)
{
    foreach (event; params.changes)
    {
        auto uri = new Uri(event.uri);

        if (["dub.json", "dub.sdl", "dub.selections.json"].canFind(baseName(uri.path)))
        {
            CodeCompleter.importSelections(uri);
        }
    }
}

auto symbol(WorkspaceSymbolParams params)
{
    SymbolInformation[] result;
    return result;
}

auto executeCommand(ExecuteCommandParams params)
{
    auto result = JSONValue(null);
    return result;
}

@serverRequest void applyEdit(ApplyWorkspaceEditResponse response)
{
}