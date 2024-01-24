-- NOTES TO OTHER DEVS:
-- Always use SingleSync, no matter what.
-- Events should only ever be listened to from one place inside a queue.
opt casing = "snake_case"
opt server_output = "src/ReplicatedStorage/net/server.luau"
opt client_output = "src/ReplicatedStorage/net/client.luau"
opt write_checks = false

-- Defined Types
type void = struct {} -- no existing alternative as of now

-- Remotes

-- * Client
event player_ready = {
	from: Client,
	type: Reliable,
	call: SingleSync,
	data: void
}

-- * Server

event unit_replication = {
	from: Server,
	type: Unreliable,
	call: SingleSync,
	data: UnitPacket
}

event general_replication = {
	from: Server,
	type: Reliable,
	call: SingleSync,
	data: ReplicationPacket
}

event despawn_entity = {
	from: Server,
	type: Reliable,
	call: SingleSync,
	data: u32[]
}