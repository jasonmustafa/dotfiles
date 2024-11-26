nvim() {
    if ! pidof socat > /dev/null 2>&1; then
        # Start socat in the background and suppress output
        socat UNIX-LISTEN:/tmp/discord-ipc-0,fork EXEC:"npiperelay.exe //./pipe/discord-ipc-0" > /dev/null 2>&1 &
        # Save the socat process ID
        export SOCAT_PID=$!
    fi

    command nvim "$@"

    # Kill the socat process after exiting Neovim
    if [[ -n $SOCAT_PID ]]; then
        kill $SOCAT_PID 2>/dev/null
        unset SOCAT_PID
    fi
}

