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
__PACKAGE__->many_to_many("roles", "role_links", "role");

sub hasRole {
	my $self = shift;
	my $roleName = shift;

	foreach my $link ($self->role_links) {
		return 1 if($link->role->name eq $roleName);
	}

	return 0;
}

sub addRole {
	my $self = shift;
	my $roleName = shift;

	warn "addRole() for user '" . $self->name . "' with roleName '" . $roleName;

	my $roleObj = $self->result_source->schema->resultset("Roles")->find($roleName, { key => "name" });

	$self->create_related("role_links", { role_id => $roleObj->id });
}

sub addRoleManyToMany {
	my $self = shift;
	my $roleName = shift;

	warn "addRoleManyToMany() for user '" . $self->name . "' with roleName '" . $roleName;
	
	my $roleObj = $self->result_source->schema->resultset("Roles")->find($roleName, { key => "name" });

	$self->add_to_roles($roleObj);
}

1;
