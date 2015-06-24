package My::Schema::Result::Roles;

use base qw/DBIx::Class::Core/;

__PACKAGE__->table("roles");
__PACKAGE__->add_columns({
	id,
	{ data_type => "int", is_nullable => 0, is_auto_increment => 1 },
	name,
	{ data_type => "varchar", size => 255, is_nullable => 0 },
});

__PACKAGE__->set_primary_key("id");

__PACKAGE__->has_many("user_links", "My::Schema::Result::UsersRoles", "role_id");

1;
