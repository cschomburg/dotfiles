self: super:

{
  ansible-with-plugins = super.ansible.overrideAttrs (old: rec {
    propagatedBuildInputs = old.propagatedBuildInputs ++ [ self.python3Packages.hcloud ];
  });
}
