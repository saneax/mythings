define scontrol::sudouser {
  ::sudo::conf { $name:
    content => "#Managed By Puppet\n${name} ALL=(ALL) NOPASSWD: ALL",
  }
}

