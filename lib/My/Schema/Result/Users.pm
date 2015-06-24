package My::Schema::Result::Users;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table("users");
__PACKAGE__->add_columns(
	"id",
	{ data_type => "int", is_nullable => 0, is_auto_increment => 1 },
	"name",
	{ data_type => "varchar", size => 255, is_nullable => 0 },
	"email",
	{ data_type => "varchar", size => 255, is_nullable => 0 }
);

__PACKAGE__->set_primary_key("id");

__PACKAGE__->has_many("role_links", "My::Schema::Result::UsersRoles", "user_id");

1;
