# apic = {
#   username = "admin"
#   password = "1234Qwer"
#   url = "https://10.72.86.12"
# }
apic = {
  username = "admin"
  password = "ciscopsdt"
  url      = "https://sandboxapicdc.cisco.com"
}

tenant = {
  name = "terraform_tenant_1"
  # description = "This tenant is created by terraform"
  # annotation  = "tag_tenant"
  # name_alias  = "alias_tenant"
}

vrfs = {
  "prod_vrf" = {
    description = "VRF Created Using Terraform"
    # annotation             = "tag_vrf"
    # bd_enforced_enable     = "no"
    # ip_data_plane_learning = "enabled"
    # knw_mcast_act          = "permit"
    # name_alias             = "alias_vrf"
    # pc_enf_dir             = "egress"
    # pc_enf_pref            = "unenforced"
  }
}

bds = {
  prod_bd = {
    vrf = "prod_vrf"
    #     description                 = "sample bridge domain"
    #     name                        = "demo_bd"
    #     optimize_wan_bandwidth      = "no"
    #     annotation                  = "tag_bd"
    #     arp_flood                   = "no"
    #     ep_clear                    = "no"
    #     ep_move_detect_mode         = "garp"
    #     host_based_routing          = "no"
    #     intersite_bum_traffic_allow = "yes"
    #     intersite_l2_stretch        = "yes"
    #     ip_learning                 = "yes"
    #     ipv6_mcast_allow            = "no"
    #     limit_ip_learn_to_subnets   = "yes"
    #     mac                         = "00:22:BD:F8:19:FF"
    #     mcast_allow                 = "yes"
    #     multi_dst_pkt_act           = "bd-flood"
    #     name_alias                  = "alias_bd"
    #     bridge_domain_type          = "regular"
    #     unicast_route               = "no"
    #     unk_mac_ucast_act           = "flood"
    #     unk_mcast_act               = "flood"
    #     vmac                        = "not-applicable"
  },
  test_bd = {}
}

subnets = {
  subnet_1 = {
    bd          = "prod_bd"
    ip          = "10.10.101.1/24"
    description = "Subnet Created Using Terraform"
  },
  subnet_2 = {
    bd          = "prod_bd"
    ip          = "10.10.102.1/24"
    description = "Subnet Created Using Terraform"
    # annotation       = "tag_subnet"
    # ctrl             = ["querier" "nd"]
    # name_alias       = "alias_subnet"
    # preferred        = "no"
    # scope            = ["private" "shared"]
    # virtual          = "yes"
  }

}

filters = {
  filter_https = {
    filter   = "https"
    entry    = "https"
    protocol = "tcp"
    port     = "443"
  },
  filter_sql = {
    filter   = "sql"
    entry    = "sql"
    protocol = "tcp"
    port     = "1433"
  }
}

contracts = {
  contract_web = {
    contract = "web"
    subject  = "https"
    filter   = "filter_https"
  },
  contract_sql = {
    contract = "sql"
    subject  = "sql"
    filter   = "filter_sql"
  }
}

ap = "intranet"

epgs = {
  web_epg = {
    epg   = "web"
    bd    = "prod_bd"
    encap = "21"
  },
  db_epg = {
    epg   = "db"
    bd    = "prod_bd"
    encap = "22"
  }
}

epg_contracts = {
  terraform_one = {
    epg           = "web_epg"
    contract      = "contract_web"
    contract_type = "provider"
  },
  terraform_two = {
    epg           = "web_epg"
    contract      = "contract_sql"
    contract_type = "consumer"
  },
  terraform_three = {
    epg           = "db_epg"
    contract      = "contract_sql"
    contract_type = "provider"
  }
}

epg_static_path = {
  static_1 = {
    epg           = "web_epg"
    tdn           = "topology/pod-1/paths-101/pathep-[eth1/1]"
    encap         = "vlan-100"
    contract_type = "provider"
  }
}

