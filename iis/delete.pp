iis_site {'Accounting':
  ensure  => absent,
}

iis_site {'minimal':
  ensure  => absent,
}