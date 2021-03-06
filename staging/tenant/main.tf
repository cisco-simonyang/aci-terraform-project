terraform {
  backend "s3" {
    bucket = "terraform-states-simyung"
    key    = "aci-automation/apic2"
    region = "ap-northeast-2"
  }
}

module "aci_tenant" {
  source = "github.com/cisco-simonyang/aci-terraform-module//tenant"

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
  }

  vrfs = {
    "prod_vrf" = {
      description = "VRF Created Using Terraform"
    }
  }

  bds = {
    prod_bd = {
      vrf = "prod_vrf"

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
}
