# fivem-instancedfix

## UPDATE

It semes like FiveM have fixed this "instanced" issue! This repo will be achived.

This FXServer resource compares server and client player count to make sure that players are not *instanced*.

## What is being instanced anyways?

Being instanced means that you wont see anyone else in the server, but you will still see sent chat messages, and other things being broadcasted server-wide. It seems to be a networking issue related with FiveM

This bug can be exploitable too! Imagine instanced players who go rob stores in RPG servers.

## Workaround

This resource puts an end to it all by simply storing all player server IDs and upon request sends it to the client(s). All clients run a loop every 15 seconds that compare the list provided by the server, and then fetches all active players.

Since instanced players wont be able to fetch active players using the `NetworkIsPlayerActive()` native there will be a difference, which then proceeds to kick the player.