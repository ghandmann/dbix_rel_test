package My::Schema::Result::UsersRoles;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table("users_roles");
__PACKAGE__->add_columns(
	"user_id",
	{ data_type => "int", is_nullable => 0 },
	"role_id",
	{ data_type => "int", is_nullable => 0 },
);

__PACKAGE__->belongs_to("user", "My::Schema::Result::Users", "user_id");
__PACKAGE__->belongs_to("role", "My::Schema::Result::Roles", "role_id");

1;
