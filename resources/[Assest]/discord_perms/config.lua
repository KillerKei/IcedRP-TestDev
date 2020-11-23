Config = {
	DiscordToken = "NzE5Mjc1NzE1NDAwNDMzNzk2.Xt9C5A.w_htq2827nSg-pKlmoYzAeQZR70",
	GuildId = "662103691280515123",

	-- Format: ["Role Nickname"] = "Role ID" You can get role id by doing \@RoleName
	Roles = {
		["TestRole"] = "Some Role ID" -- This would be checked by doing exports.discord_perms:IsRolePresent(user, "TestRole")
	}
}
