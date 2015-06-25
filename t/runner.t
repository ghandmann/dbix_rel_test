use Test::More;
use strict;
use warnings;

use Test::DBIx::Class {
	schema_class => "My::Schema",
	connect_info => ["dbi:SQLite:dbname=:memory", "", ""]
}, ":resultsets";

fixtures_ok [
	Users => [
		["id", "name", "email"],
		[1, "UserA", "UserA\@some.host"],
		[2, "UserB", "UserB\@some.host"],
		[3, "UserC", "UserC\@some.host"]
	],
	Roles => [
		["id", "name"],
		[1, "Admin"],
		[2, "User"],
		[3, "Support"],
	],
	UsersRoles => [
		["user_id", "role_id"],
		[1, 1],
		[2, 2],
		[3, 3],
	]
], "Installed basic fixtures";

my $userA = Users->find(1, { prefetch => { role_links => "role" } });
is($userA->name, "UserA", "UserA is named UserA");
ok($userA->hasRole("Admin"), "UserA is Admin");
ok(!$userA->hasRole("Support"), "UserA is NOT Support");

$userA->addRole("Support");
ok($userA->hasRole("Support"), "UserA is now Support");

ok(!$userA->hasRole("User"), "UserA is NOT User");
$userA->addRoleManyToMany("User");
ok($userA->hasRole("User"), "UserA is User");


done_testing();
