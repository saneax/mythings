class scontrol::accounts (
  $localusers={},
  $sudousers=[],
) {
  notice ("$localusers I have")
  $users = hiera ('scontrol::accounts::localusers', {})
  $sudoers = hiera ('scontrol::accounts::sudousers', [])
  notice ("I Got [users=$users] and [sudoers=$sudoers] from hiera")

  create_resources('scontrol::localuser',$users)
  scontrol::sudouser { $sudoers: }

}

