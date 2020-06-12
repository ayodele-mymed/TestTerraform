resource "aws_cloudformation_stack" "instanceScheduler" {
  name = "Schedule"
  capabilities = ["CAPABILITY_IAM"]
template_body = <<STACK
{
    "Parameters": {
        "SchedulingActive": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "Yes",
            "Description": "Activate or deactivate scheduling."
        },
        "ScheduledServices": {
            "Type": "String",
            "AllowedValues": [
                "EC2",
                "RDS",
                "Both"
            ],
            "Default": "EC2",
            "Description": "Scheduled Services."
        },
        "ScheduleRdsClusters": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "No",
            "Description": "Enable scheduling of Aurora clusters for RDS Service."
        },
        "CreateRdsSnapshot": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "Yes",
            "Description": "Create snapshot before stopping RDS instances(does not apply to Aurora Clusters)."
        },
        "MemorySize": {
            "Type": "Number",
            "AllowedValues": [
                128,
                384,
                512,
                640,
                768,
                896,
                1024,
                1152,
                1280,
                1408,
                1536
            ],
            "Default": 128,
            "Description": "Size of the Lambda function running the scheduler, increase size when processing large numbers of instances"
        },
        "UseCloudWatchMetrics": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "No",
            "Description": "Collect instance scheduling data using CloudWatch metrics."
        },
        "LogRetentionDays": {
            "Type": "Number",
            "Default": 30,
            "AllowedValues": [
                1,
                3,
                5,
                7,
                14,
                30,
                60,
                90,
                120,
                150,
                180,
                365,
                400,
                545,
                731,
                1827,
                3653
            ],
            "Description": "Retention days for scheduler logs."
        },
        "Trace": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "No",
            "Description": "Enable logging of detailed informtion in CloudWatch logs."
        },
        "TagName": {
            "Type": "String",
            "Default": "Schedule",
            "MinLength": 1,
            "MaxLength": 127,
            "Description": "Name of tag to use for associating instance schedule schemas with service instances."
        },
        "DefaultTimezone": {
            "Type": "String",
            "Default": "Asia/Kolkata",
            "AllowedValues": [
                "Africa/Abidjan",
                "Africa/Accra",
                "Africa/Addis_Ababa",
                "Africa/Algiers",
                "Africa/Asmara",
                "Africa/Bamako",
                "Africa/Bangui",
                "Africa/Banjul",
                "Africa/Bissau",
                "Africa/Blantyre",
                "Africa/Brazzaville",
                "Africa/Bujumbura",
                "Africa/Cairo",
                "Africa/Casablanca",
                "Africa/Ceuta",
                "Africa/Conakry",
                "Africa/Dakar",
                "Africa/Dar_es_Salaam",
                "Africa/Djibouti",
                "Africa/Douala",
                "Africa/El_Aaiun",
                "Africa/Freetown",
                "Africa/Gaborone",
                "Africa/Harare",
                "Africa/Johannesburg",
                "Africa/Juba",
                "Africa/Kampala",
                "Africa/Khartoum",
                "Africa/Kigali",
                "Africa/Kinshasa",
                "Africa/Lagos",
                "Africa/Libreville",
                "Africa/Lome",
                "Africa/Luanda",
                "Africa/Lubumbashi",
                "Africa/Lusaka",
                "Africa/Malabo",
                "Africa/Maputo",
                "Africa/Maseru",
                "Africa/Mbabane",
                "Africa/Mogadishu",
                "Africa/Monrovia",
                "Africa/Nairobi",
                "Africa/Ndjamena",
                "Africa/Niamey",
                "Africa/Nouakchott",
                "Africa/Ouagadougou",
                "Africa/Porto-Novo",
                "Africa/Sao_Tome",
                "Africa/Tripoli",
                "Africa/Tunis",
                "Africa/Windhoek",
                "America/Adak",
                "America/Anchorage",
                "America/Anguilla",
                "America/Antigua",
                "America/Araguaina",
                "America/Argentina/Buenos_Aires",
                "America/Argentina/Catamarca",
                "America/Argentina/Cordoba",
                "America/Argentina/Jujuy",
                "America/Argentina/La_Rioja",
                "America/Argentina/Mendoza",
                "America/Argentina/Rio_Gallegos",
                "America/Argentina/Salta",
                "America/Argentina/San_Juan",
                "America/Argentina/San_Luis",
                "America/Argentina/Tucuman",
                "America/Argentina/Ushuaia",
                "America/Aruba",
                "America/Asuncion",
                "America/Atikokan",
                "America/Bahia",
                "America/Bahia_Banderas",
                "America/Barbados",
                "America/Belem",
                "America/Belize",
                "America/Blanc-Sablon",
                "America/Boa_Vista",
                "America/Bogota",
                "America/Boise",
                "America/Cambridge_Bay",
                "America/Campo_Grande",
                "America/Cancun",
                "America/Caracas",
                "America/Cayenne",
                "America/Cayman",
                "America/Chicago",
                "America/Chihuahua",
                "America/Costa_Rica",
                "America/Creston",
                "America/Cuiaba",
                "America/Curacao",
                "America/Danmarkshavn",
                "America/Dawson",
                "America/Dawson_Creek",
                "America/Denver",
                "America/Detroit",
                "America/Dominica",
                "America/Edmonton",
                "America/Eirunepe",
                "America/El_Salvador",
                "America/Fortaleza",
                "America/Glace_Bay",
                "America/Godthab",
                "America/Goose_Bay",
                "America/Grand_Turk",
                "America/Grenada",
                "America/Guadeloupe",
                "America/Guatemala",
                "America/Guayaquil",
                "America/Guyana",
                "America/Halifax",
                "America/Havana",
                "America/Hermosillo",
                "America/Indiana/Indianapolis",
                "America/Indiana/Knox",
                "America/Indiana/Marengo",
                "America/Indiana/Petersburg",
                "America/Indiana/Tell_City",
                "America/Indiana/Vevay",
                "America/Indiana/Vincennes",
                "America/Indiana/Winamac",
                "America/Inuvik",
                "America/Iqaluit",
                "America/Jamaica",
                "America/Juneau",
                "America/Kentucky/Louisville",
                "America/Kentucky/Monticello",
                "America/Kralendijk",
                "America/La_Paz",
                "America/Lima",
                "America/Los_Angeles",
                "America/Lower_Princes",
                "America/Maceio",
                "America/Managua",
                "America/Manaus",
                "America/Marigot",
                "America/Martinique",
                "America/Matamoros",
                "America/Mazatlan",
                "America/Menominee",
                "America/Merida",
                "America/Metlakatla",
                "America/Mexico_City",
                "America/Miquelon",
                "America/Moncton",
                "America/Monterrey",
                "America/Montevideo",
                "America/Montreal",
                "America/Montserrat",
                "America/Nassau",
                "America/New_York",
                "America/Nipigon",
                "America/Nome",
                "America/Noronha",
                "America/North_Dakota/Beulah",
                "America/North_Dakota/Center",
                "America/North_Dakota/New_Salem",
                "America/Ojinaga",
                "America/Panama",
                "America/Pangnirtung",
                "America/Paramaribo",
                "America/Phoenix",
                "America/Port-au-Prince",
                "America/Port_of_Spain",
                "America/Porto_Velho",
                "America/Puerto_Rico",
                "America/Rainy_River",
                "America/Rankin_Inlet",
                "America/Recife",
                "America/Regina",
                "America/Resolute",
                "America/Rio_Branco",
                "America/Santa_Isabel",
                "America/Santarem",
                "America/Santiago",
                "America/Santo_Domingo",
                "America/Sao_Paulo",
                "America/Scoresbysund",
                "America/Sitka",
                "America/St_Barthelemy",
                "America/St_Johns",
                "America/St_Kitts",
                "America/St_Lucia",
                "America/St_Thomas",
                "America/St_Vincent",
                "America/Swift_Current",
                "America/Tegucigalpa",
                "America/Thule",
                "America/Thunder_Bay",
                "America/Tijuana",
                "America/Toronto",
                "America/Tortola",
                "America/Vancouver",
                "America/Whitehorse",
                "America/Winnipeg",
                "America/Yakutat",
                "America/Yellowknife",
                "Antarctica/Casey",
                "Antarctica/Davis",
                "Antarctica/DumontDUrville",
                "Antarctica/Macquarie",
                "Antarctica/Mawson",
                "Antarctica/McMurdo",
                "Antarctica/Palmer",
                "Antarctica/Rothera",
                "Antarctica/Syowa",
                "Antarctica/Vostok",
                "Arctic/Longyearbyen",
                "Asia/Aden",
                "Asia/Almaty",
                "Asia/Amman",
                "Asia/Anadyr",
                "Asia/Aqtau",
                "Asia/Aqtobe",
                "Asia/Ashgabat",
                "Asia/Baghdad",
                "Asia/Bahrain",
                "Asia/Baku",
                "Asia/Bangkok",
                "Asia/Beirut",
                "Asia/Bishkek",
                "Asia/Brunei",
                "Asia/Choibalsan",
                "Asia/Chongqing",
                "Asia/Colombo",
                "Asia/Damascus",
                "Asia/Dhaka",
                "Asia/Dili",
                "Asia/Dubai",
                "Asia/Dushanbe",
                "Asia/Gaza",
                "Asia/Harbin",
                "Asia/Hebron",
                "Asia/Ho_Chi_Minh",
                "Asia/Hong_Kong",
                "Asia/Hovd",
                "Asia/Irkutsk",
                "Asia/Jakarta",
                "Asia/Jayapura",
                "Asia/Jerusalem",
                "Asia/Kabul",
                "Asia/Kamchatka",
                "Asia/Karachi",
                "Asia/Kashgar",
                "Asia/Kathmandu",
                "Asia/Khandyga",
                "Asia/Kolkata",
                "Asia/Krasnoyarsk",
                "Asia/Kuala_Lumpur",
                "Asia/Kuching",
                "Asia/Kuwait",
                "Asia/Macau",
                "Asia/Magadan",
                "Asia/Makassar",
                "Asia/Manila",
                "Asia/Muscat",
                "Asia/Nicosia",
                "Asia/Novokuznetsk",
                "Asia/Novosibirsk",
                "Asia/Omsk",
                "Asia/Oral",
                "Asia/Phnom_Penh",
                "Asia/Pontianak",
                "Asia/Pyongyang",
                "Asia/Qatar",
                "Asia/Qyzylorda",
                "Asia/Rangoon",
                "Asia/Riyadh",
                "Asia/Sakhalin",
                "Asia/Samarkand",
                "Asia/Seoul",
                "Asia/Shanghai",
                "Asia/Singapore",
                "Asia/Taipei",
                "Asia/Tashkent",
                "Asia/Tbilisi",
                "Asia/Tehran",
                "Asia/Thimphu",
                "Asia/Tokyo",
                "Asia/Ulaanbaatar",
                "Asia/Urumqi",
                "Asia/Ust-Nera",
                "Asia/Vientiane",
                "Asia/Vladivostok",
                "Asia/Yakutsk",
                "Asia/Yekaterinburg",
                "Asia/Yerevan",
                "Atlantic/Azores",
                "Atlantic/Bermuda",
                "Atlantic/Canary",
                "Atlantic/Cape_Verde",
                "Atlantic/Faroe",
                "Atlantic/Madeira",
                "Atlantic/Reykjavik",
                "Atlantic/South_Georgia",
                "Atlantic/St_Helena",
                "Atlantic/Stanley",
                "Australia/Adelaide",
                "Australia/Brisbane",
                "Australia/Broken_Hill",
                "Australia/Currie",
                "Australia/Darwin",
                "Australia/Eucla",
                "Australia/Hobart",
                "Australia/Lindeman",
                "Australia/Lord_Howe",
                "Australia/Melbourne",
                "Australia/Perth",
                "Australia/Sydney",
                "Canada/Atlantic",
                "Canada/Central",
                "Canada/Eastern",
                "Canada/Mountain",
                "Canada/Newfoundland",
                "Canada/Pacific",
                "Europe/Amsterdam",
                "Europe/Andorra",
                "Europe/Athens",
                "Europe/Belgrade",
                "Europe/Berlin",
                "Europe/Bratislava",
                "Europe/Brussels",
                "Europe/Bucharest",
                "Europe/Budapest",
                "Europe/Busingen",
                "Europe/Chisinau",
                "Europe/Copenhagen",
                "Europe/Dublin",
                "Europe/Gibraltar",
                "Europe/Guernsey",
                "Europe/Helsinki",
                "Europe/Isle_of_Man",
                "Europe/Istanbul",
                "Europe/Jersey",
                "Europe/Kaliningrad",
                "Europe/Kiev",
                "Europe/Lisbon",
                "Europe/Ljubljana",
                "Europe/London",
                "Europe/Luxembourg",
                "Europe/Madrid",
                "Europe/Malta",
                "Europe/Mariehamn",
                "Europe/Minsk",
                "Europe/Monaco",
                "Europe/Moscow",
                "Europe/Oslo",
                "Europe/Paris",
                "Europe/Podgorica",
                "Europe/Prague",
                "Europe/Riga",
                "Europe/Rome",
                "Europe/Samara",
                "Europe/San_Marino",
                "Europe/Sarajevo",
                "Europe/Simferopol",
                "Europe/Skopje",
                "Europe/Sofia",
                "Europe/Stockholm",
                "Europe/Tallinn",
                "Europe/Tirane",
                "Europe/Uzhgorod",
                "Europe/Vaduz",
                "Europe/Vatican",
                "Europe/Vienna",
                "Europe/Vilnius",
                "Europe/Volgograd",
                "Europe/Warsaw",
                "Europe/Zagreb",
                "Europe/Zaporozhye",
                "Europe/Zurich",
                "GMT",
                "Indian/Antananarivo",
                "Indian/Chagos",
                "Indian/Christmas",
                "Indian/Cocos",
                "Indian/Comoro",
                "Indian/Kerguelen",
                "Indian/Mahe",
                "Indian/Maldives",
                "Indian/Mauritius",
                "Indian/Mayotte",
                "Indian/Reunion",
                "Pacific/Apia",
                "Pacific/Auckland",
                "Pacific/Chatham",
                "Pacific/Chuuk",
                "Pacific/Easter",
                "Pacific/Efate",
                "Pacific/Enderbury",
                "Pacific/Fakaofo",
                "Pacific/Fiji",
                "Pacific/Funafuti",
                "Pacific/Galapagos",
                "Pacific/Gambier",
                "Pacific/Guadalcanal",
                "Pacific/Guam",
                "Pacific/Honolulu",
                "Pacific/Johnston",
                "Pacific/Kiritimati",
                "Pacific/Kosrae",
                "Pacific/Kwajalein",
                "Pacific/Majuro",
                "Pacific/Marquesas",
                "Pacific/Midway",
                "Pacific/Nauru",
                "Pacific/Niue",
                "Pacific/Norfolk",
                "Pacific/Noumea",
                "Pacific/Pago_Pago",
                "Pacific/Palau",
                "Pacific/Pitcairn",
                "Pacific/Pohnpei",
                "Pacific/Port_Moresby",
                "Pacific/Rarotonga",
                "Pacific/Saipan",
                "Pacific/Tahiti",
                "Pacific/Tarawa",
                "Pacific/Tongatapu",
                "Pacific/Wake",
                "Pacific/Wallis",
                "US/Alaska",
                "US/Arizona",
                "US/Central",
                "US/Eastern",
                "US/Hawaii",
                "US/Mountain",
                "US/Pacific",
                "UTC"
            ],
            "Description": "Choose the default Time Zone. Default is 'UTC'"
        },
        "Regions": {
            "Type": "CommaDelimitedList",
            "Default":"us-east-1",
            "Description": "List of regions in which instances are scheduled, leave blank for current region only."
        },
         "CrossAccountRoles": {	
            "Type": "CommaDelimitedList",	
            "Description": "Comma separated list of ARN's for cross account access roles. These roles must be created in all checked accounts the scheduler to start and stop instances."	
        },
        "StartedTags": {
            "Type": "String",
            "Default":"schedStarted=true",
            "Description": "Comma separated list of tagname and values on the formt name=value,name=value,.. that are set on started instances"
        },
        "StoppedTags": {
            "Type": "String",
            "Default":"schedStoped=true",
            "Description": "Comma separated list of tagname and values on the formt name=value,name=value,.. that are set on stopped instances"
        },
        "SchedulerFrequency": {
            "Type": "String",
            "AllowedValues": [
                "1",
                "2",
                "5",
                "10",
                "15",
                "30",
                "60"
            ],
            "Default": "1",
            "Description": "Scheduler running frequency in minutes."
        },
        "ScheduleLambdaAccount": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "Yes",
            "Description": "Schedule instances in this account."
        },
        "SendAnonymousData": {
            "Type": "String",
            "AllowedValues": [
                "Yes",
                "No"
            ],
            "Default": "Yes",
            "Description": "Send Anonymous Metrics Data."
        }
    },
    "Metadata": {
        "AWS::CloudFormation::Interface": {
            "ParameterGroups": [
                {
                    "Label": {
                        "default": "Scheduler (version v1.3.1)"
                    },
                    "Parameters": [
                        "TagName",
                        "ScheduledServices",
                        "ScheduleRdsClusters",
                        "CrossAccountRoles",
                        "CreateRdsSnapshot",
                        "SchedulingActive",
                        "Regions",
                        "DefaultTimezone",
                        "ScheduleLambdaAccount",
                        "SchedulerFrequency",
                        "MemorySize"
                    ]
                },
                {
                    "Label": {
                        "default": "Options"
                    },
                    "Parameters": [
                        "UseCloudWatchMetrics",
                        "SendAnonymousData",
                        "Trace"
                    ]
                },
                {
                    "Label": {
                        "default": "Other parameters"
                    },
                    "Parameters": [
                        "LogRetentionDays",
                        "StartedTags",
                        "StoppedTags"
                    ]
                }
            ],
            "ParameterLabels": {
                "LogRetentionDays": {
                    "default": "Log retention days"
                },
                "StartedTags": {
                    "default": "Started tags"
                },
                "StoppedTags": {
                    "default": "Stopped tags"
                },
                "SchedulingActive": {
                    "default": "Scheduling enabled"
                },
                 "CrossAccountRoles": {	
                    "default": "Cross-account roles"	
                },
                "ScheduleLambdaAccount": {
                    "default": "This account"
                },
                "UseCloudWatchMetrics": {
                    "default": "Enable CloudWatch Metrics"
                },
                "Trace": {
                    "default": "Enable CloudWatch Logs"
                },
                "TagName": {
                    "default": "Instance Scheduler tag name"
                },
                "ScheduledServices": {
                    "default": "Service(s) to schedule"
                },
                "ScheduleRdsClusters": {
                    "default": "Schedule Aurora Clusters"
                },
                "CreateRdsSnapshot": {
                    "default": "Create RDS instance snapshot"
                },
                "DefaultTimezone": {
                    "default": "Default time zone"
                },
                "SchedulerFrequency": {
                    "default": "Frequency"
                },
                "Regions": {
                    "default": "Region(s)"
                },
                "MemorySize": {
                    "default": "Memory size"
                },
                "SendAnonymousData": {
                    "default": "Send anonymous usage data"
                }
            }
        }
    },
    "Mappings": {
        "TrueFalse": {
            "Yes": {
                "Value": "True"
            },
            "No": {
                "Value": "False"
            }
        },
        "EnabledDisabled": {
            "Yes": {
                "Value": "ENABLED"
            },
            "No": {
                "Value": "DISABLED"
            }
        },
        "Services": {
            "EC2": {
                "Value": "ec2"
            },
            "RDS": {
                "Value": "rds"
            },
            "Both": {
                "Value": "ec2,rds"
            }
        },
        "Timeouts": {
            "1": {
                "Value": "cron(0/1 * * * ? *)"
            },
            "2": {
                "Value": "cron(0/2 * * * ? *)"
            },
            "5": {
                "Value": "cron(0/5 * * * ? *)"
            },
            "10": {
                "Value": "cron(0/10 * * * ? *)"
            },
            "15": {
                "Value": "cron(0/15 * * * ? *)"
            },
            "30": {
                "Value": "cron(0/30 * * * ? *)"
            },
            "60": {
                "Value": "cron(0 0/1 * * ? *)"
            }
        },
        "Settings": {
            "Metrics": {
                "Url": "https://metrics.awssolutionsbuilder.com/generic",
                "SolutionId": "S00030"
            },
            "RdsTagCaching": {
                "Enabled": "True"
            }
        }
    },
    "Resources": {
        "InstanceSchedulerEncryptionKey": {
            "Type": "AWS::KMS::Key",
            "Properties": {
                "Description": "Key for SNS",
                "Enabled": true,
                "EnableKeyRotation": true,
                "KeyPolicy": {
                    "Statement": [
                        {
                            "Sid": "default",
                            "Effect": "Allow",
                            "Principal": {
                                "AWS": {	
                                    "Fn::Sub": "arn:${AWS::Partition}:iam::${AWS::AccountId}:root"	
                                }	
                            },
                            "Action": "kms:*",
                            "Resource": "*"
                        },
                        {
                            "Sid": "Allows use of key",
                            "Effect": "Allow",
                            "Principal": {
                                "AWS": {
                                    "Fn::GetAtt": [
                                        "SchedulerRole",
                                        "Arn"
                                    ]
                                }
                            },
                            "Action": [
                                "kms:GenerateDataKey*",
                                "kms:Decrypt"
                            ],
                            "Resource": "*"
                        }
                    ]
                }
            }
        },
        "InstanceSchedulerEncryptionKeyAlias": {
            "Type": "AWS::KMS::Alias",
            "Properties": {
                "AliasName": "alias/instance-scheduler-encryption-key",
                "TargetKeyId": {
                    "Ref": "InstanceSchedulerEncryptionKey"
                }
            }
        },
        "SchedulerPolicy": {
            "Type": "AWS::IAM::Policy",
            "Metadata": {
                "cfn_nag": {
                    "rules_to_suppress": [
                        {
                            "id": "W12",
                            "reason": "All policies have been scoped to be as restrictive as possible. This solution needs to access ec2/rds resources across all regions."
                        }
                    ]
                }
            },
            "Properties": {
                "PolicyName": "SchedulerPolicy",
                "Roles": [
                    {
                        "Ref": "SchedulerRole"
                    }
                ],
                "PolicyDocument": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Action": [
                                "logs:CreateLogGroup",
                                "logs:CreateLogStream",
                                "logs:PutLogEvents",
                                "logs:PutRetentionPolicy"
                            ],
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        ":",
                                        [
                                            "arn:aws:logs",
                                            {
                                                "Ref": "AWS::Region"
                                            },
                                            {
                                                "Ref": "AWS::AccountId"
                                            },
                                            "log-group",
                                            {
                                                "Ref": "SchedulerLogGroup"
                                            },
                                            "*"
                                        ]
                                    ]
                                },
                                {
                                    "Fn::Join": [
                                        ":",
                                        [
                                            "arn:aws:logs",
                                            {
                                                "Ref": "AWS::Region"
                                            },
                                            {
                                                "Ref": "AWS::AccountId"
                                            },
                                            "log-group:/aws/lambda/*"
                                        ]
                                    ]
                                }
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "rds:DeleteDBSnapshot",
                                "rds:DescribeDBSnapshots",
                                "rds:StopDBInstance"
                            ],
                            "Resource": {
                                "Fn::Join": [
                                    ":",
                                    [
                                        "arn:aws:rds:*",
                                        {
                                            "Ref": "AWS::AccountId"
                                        },
                                        "snapshot:*"
                                    ]
                                ]
                            }
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "rds:AddTagsToResource",
                                "rds:RemoveTagsFromResource",
                                "rds:DescribeDBSnapshots",
                                "rds:StartDBInstance",
                                "rds:StopDBInstance"
                            ],
                            "Resource": {
                                "Fn::Join": [
                                    ":",
                                    [
                                        "arn:aws:rds:*",
                                        {
                                            "Ref": "AWS::AccountId"
                                        },
                                        "db:*"
                                    ]
                                ]
                            }
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "rds:AddTagsToResource",
                                "rds:RemoveTagsFromResource",
                                "rds:StartDBCluster",
                                "rds:StopDBCluster"
                            ],
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        ":",
                                        [
                                            "arn:aws:rds:*",
                                            {
                                                "Ref": "AWS::AccountId"
                                            },
                                            "cluster:*"
                                        ]
                                    ]
                                }
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "ec2:StartInstances",
                                "ec2:StopInstances",
                                "ec2:CreateTags",
                                "ec2:DeleteTags"
                            ],
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        ":",
                                        [
                                            "arn:aws:ec2:*",
                                            {
                                                "Ref": "AWS::AccountId"
                                            },
                                            "instance/*"
                                        ]
                                    ]
                                }
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "dynamodb:DeleteItem",
                                "dynamodb:GetItem",
                                "dynamodb:PutItem",
                                "dynamodb:Query",
                                "dynamodb:Scan",
                                "dynamodb:BatchWriteItem"
                            ],
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            {
                                                "Fn::Join": [
                                                    ":",
                                                    [
                                                        "arn:aws:dynamodb",
                                                        {
                                                            "Ref": "AWS::Region"
                                                        },
                                                        {
                                                            "Ref": "AWS::AccountId"
                                                        },
                                                        "table/"
                                                    ]
                                                ]
                                            },
                                            {
                                                "Ref": "StateTable"
                                            }
                                        ]
                                    ]
                                },
                                {
                                    "Fn::Join": [
                                        "",
                                        [
                                            {
                                                "Fn::Join": [
                                                    ":",
                                                    [
                                                        "arn:aws:dynamodb",
                                                        {
                                                            "Ref": "AWS::Region"
                                                        },
                                                        {
                                                            "Ref": "AWS::AccountId"
                                                        },
                                                        "table/"
                                                    ]
                                                ]
                                            },
                                            {
                                                "Ref": "ConfigTable"
                                            }
                                        ]
                                    ]
                                }
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": "sns:Publish",
                            "Resource": [
                                {
                                    "Ref": "InstanceSchedulerSnsTopic"
                                }
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "lambda:InvokeFunction"
                            ],
                            "Resource": [
                                {
                                    "Fn::Join": [
                                        ":",
                                        [
                                            "arn:aws:lambda",
                                            {
                                                "Ref": "AWS::Region"
                                            },
                                            {
                                                "Ref": "AWS::AccountId"
                                            },
                                            "function",
                                            {
                                                "Fn::Join": [
                                                    "-",
                                                    [
                                                        {
                                                            "Ref": "AWS::StackName"
                                                        },
                                                        "InstanceSchedulerMain"
                                                    ]
                                                ]
                                            }
                                        ]
                                    ]
                                }
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "logs:DescribeLogStreams",
                                "rds:DescribeDBClusters",
                                "rds:DescribeDBInstances",
                                "ec2:DescribeInstances",
                                "ec2:DescribeRegions",
                                "ec2:ModifyInstanceAttribute",
                                "cloudwatch:PutMetricData",
                                "ssm:GetParameter",
                                "ssm:GetParameters",
                                "ssm:DescribeMaintenanceWindows",
                                "ssm:DescribeMaintenanceWindowExecutions",
                                "tag:GetResources",
                                "sts:AssumeRole"
                            ],
                            "Resource": [
                                "*"
                            ]
                        },
                        {
                            "Effect": "Allow",
                            "Action": [
                                "kms:GenerateDataKey*",
                                "kms:Decrypt"
                            ],
                            "Resource": [
                                {
                                    "Fn::GetAtt": [
                                        "InstanceSchedulerEncryptionKey",
                                        "Arn"
                                    ]
                                }
                            ]
                        }
                    ]
                }
            }
        },
        "SchedulerRole": {
            "Type": "AWS::IAM::Role",
            "Properties": {
                "AssumeRolePolicyDocument": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Principal": {
                                "Service": "lambda.amazonaws.com"
                            },
                            "Action": "sts:AssumeRole"
                        },
                        {
                            "Effect": "Allow",
                            "Principal": {
                                "Service": "events.amazonaws.com"
                            },
                            "Action": "sts:AssumeRole"
                        }
                    ]
                },
                "Path": "/"
            }
        },
        "StateTable": {
            "Type": "AWS::DynamoDB::Table",
            "Properties": {
                "AttributeDefinitions": [
                    {
                        "AttributeName": "service",
                        "AttributeType": "S"
                    },
                    {
                        "AttributeName": "account-region",
                        "AttributeType": "S"
                    }
                ],
                "KeySchema": [
                    {
                        "AttributeName": "service",
                        "KeyType": "HASH"
                    },
                    {
                        "AttributeName": "account-region",
                        "KeyType": "RANGE"
                    }
                ],
                "BillingMode": "PAY_PER_REQUEST"
            }
        },
        "ConfigTable": {
            "Type": "AWS::DynamoDB::Table",
            "Properties": {
                "AttributeDefinitions": [
                    {
                        "AttributeName": "type",
                        "AttributeType": "S"
                    },
                    {
                        "AttributeName": "name",
                        "AttributeType": "S"
                    }
                ],
                "KeySchema": [
                    {
                        "AttributeName": "type",
                        "KeyType": "HASH"
                    },
                    {
                        "AttributeName": "name",
                        "KeyType": "RANGE"
                    }
                ],
                "BillingMode": "PAY_PER_REQUEST"
            }
        },
        "SchedulerLogGroup": {
            "Type": "AWS::Logs::LogGroup",
            "Properties": {
                "LogGroupName": {
                    "Fn::Join": [
                        "-",
                        [
                            {
                                "Ref": "AWS::StackName"
                            },
                            "logs"
                        ]
                    ]
                },
                "RetentionInDays": {
                    "Ref": "LogRetentionDays"
                }
            }
        },
        "InstanceSchedulerSnsTopic": {
            "Type": "AWS::SNS::Topic",
            "Properties": {
                "KmsMasterKeyId": {
                    "Ref": "InstanceSchedulerEncryptionKey"
                },
                "DisplayName": {
                    "Ref": "AWS::StackName"
                }
            }
        },
        "Main": {
            "Type": "AWS::Lambda::Function",
            "Metadata": {
                "cfn_nag": {
                    "rules_to_suppress": [
                        {
                            "id": "W58",
                            "reason": "All policies have been scoped to be as restrictive as possible. This lambda function has access to write logs."
                        }
                    ]
                }
            },
            "Properties": {
                "FunctionName": {
                    "Fn::Join": [
                        "-",
                        [
                            {
                                "Ref": "AWS::StackName"
                            },
                            "InstanceSchedulerMain"
                        ]
                    ]
                },
                "Code": {
                    "S3Bucket": {
                        "Fn::Join": [
                            "-",
                            [
                                "solutions",
                                {
                                    "Ref": "AWS::Region"
                                }
                            ]
                        ]
                    },
                    "S3Key": "aws-instance-scheduler/v1.3.1/instance-scheduler.zip"
                },
                "Handler": "main.lambda_handler",
                "Runtime": "python3.7",
                "Role": {
                    "Fn::GetAtt": [
                        "SchedulerRole",
                        "Arn"
                    ]
                },
                "Environment": {
                    "Variables": {
                        "CONFIG_TABLE": {
                            "Ref": "ConfigTable"
                        },
                        "SCHEDULER_FREQUENCY": {
                            "Ref": "SchedulerFrequency"
                        },
                        "TAG_NAME": {
                            "Ref": "TagName"
                        },
                        "STATE_TABLE": {
                            "Ref": "StateTable"
                        },
                        "LOG_GROUP": {
                            "Ref": "SchedulerLogGroup"
                        },
                        "ACCOUNT": {
                            "Ref": "AWS::AccountId"
                        },
                        "ISSUES_TOPIC_ARN": {
                            "Ref": "InstanceSchedulerSnsTopic"
                        },
                        "STACK_NAME": {
                            "Ref": "AWS::StackName"
                        },
                        "BOTO_RETRY": "5,10,30,0.25",
                        "ENV_BOTO_RETRY_LOGGING": "False",
                        "SEND_METRICS": {
                            "Fn::FindInMap": [
                                "TrueFalse",
                                {
                                    "Ref": "SendAnonymousData"
                                },
                                "Value"
                            ]
                        },
                        "SOLUTION_ID": {
                            "Fn::FindInMap": [
                                "Settings",
                                "Metrics",
                                "SolutionId"
                            ]
                        },
                        "TRACE": {
                            "Fn::FindInMap": [
                                "TrueFalse",
                                {
                                    "Ref": "Trace"
                                },
                                "Value"
                            ]
                        },
                        "USER_AGENT": {
                            "Fn::Join": [
                                "-",
                                [
                                    "InstanceScheduler",
                                    {
                                        "Ref": "AWS::StackName"
                                    },
                                    "v1.3.1"
                                ]
                            ]
                        },
                        "METRICS_URL": {
                            "Fn::FindInMap": [
                                "Settings",
                                "Metrics",
                                "Url"
                            ]
                        },
                        "SCHEDULER_RULE": {
                            "Ref": "SchedulerRule"
                        }
                    }
                },
                "MemorySize": {
                    "Ref": "MemorySize"
                },
                "Timeout": 300,
                "Description": "EC2 and RDS instance scheduler, version v1.3.1"
            },
            "DependsOn": [
                "SchedulerPolicy"
            ]
        },
        "SchedulerInvokePermission": {
            "Type": "AWS::Lambda::Permission",
            "Properties": {
                "FunctionName": {
                    "Fn::Join": [
                        ":",
                        [
                            "arn:aws:lambda",
                            {
                                "Ref": "AWS::Region"
                            },
                            {
                                "Ref": "AWS::AccountId"
                            },
                            "function",
                            {
                                "Fn::Join": [
                                    "-",
                                    [
                                        {
                                            "Ref": "AWS::StackName"
                                        },
                                        "InstanceSchedulerMain"
                                    ]
                                ]
                            }
                        ]
                    ]
                },
                "Action": "lambda:InvokeFunction",
                "Principal": "events.amazonaws.com",
                "SourceArn": {
                    "Fn::GetAtt": [
                        "SchedulerRule",
                        "Arn"
                    ]
                }
            },
            "DependsOn": "Main"
        },
        "SchedulerRule": {
            "Type": "AWS::Events::Rule",
            "Properties": {
                "Description": "Instance Scheduler - Rule to trigger instance for scheduler function version v1.3.1",
                "ScheduleExpression": {
                    "Fn::FindInMap": [
                        "Timeouts",
                        {
                            "Ref": "SchedulerFrequency"
                        },
                        "Value"
                    ]
                },
                "State": {
                    "Fn::FindInMap": [
                        "EnabledDisabled",
                        {
                            "Ref": "SchedulingActive"
                        },
                        "Value"
                    ]
                },
                "Targets": [
                    {
                        "Id": "MainFunction",
                        "Arn": {
                            "Fn::Join": [
                                ":",
                                [
                                    "arn:aws:lambda",
                                    {
                                        "Ref": "AWS::Region"
                                    },
                                    {
                                        "Ref": "AWS::AccountId"
                                    },
                                    "function",
                                    {
                                        "Fn::Join": [
                                            "-",
                                            [
                                                {
                                                    "Ref": "AWS::StackName"
                                                },
                                                "InstanceSchedulerMain"
                                            ]
                                        ]
                                    }
                                ]
                            ]
                        }
                    }
                ]
            }
        },
        "SchedulerConfigHelper": {
            "Type": "Custom::ServiceSetup",
            "Properties": {
                "ServiceToken": {
                    "Fn::GetAtt": [
                        "Main",
                        "Arn"
                    ]
                },
                "timeout": "120",
                "config_table": {
                    "Ref": "ConfigTable"
                },
                "tagname": {
                    "Ref": "TagName"
                },
                "default_timezone": {
                    "Ref": "DefaultTimezone"
                },
                "use_metrics": {
                    "Fn::FindInMap": [
                        "TrueFalse",
                        {
                            "Ref": "UseCloudWatchMetrics"
                        },
                        "Value"
                    ]
                },
                "scheduled_services": {
                    "Fn::Split": [
                        ",",
                        {
                            "Fn::FindInMap": [
                                "Services",
                                {
                                    "Ref": "ScheduledServices"
                                },
                                "Value"
                            ]
                        }
                    ]
                },
                "schedule_clusters": {
                    "Fn::FindInMap": [
                        "TrueFalse",
                        {
                            "Ref": "ScheduleRdsClusters"
                        },
                        "Value"
                    ]
                },
                "create_rds_snapshot": {
                    "Fn::FindInMap": [
                        "TrueFalse",
                        {
                            "Ref": "CreateRdsSnapshot"
                        },
                        "Value"
                    ]
                },
                "regions": {
                    "Ref": "Regions"
                },
                "schedule_lambda_account": {
                    "Fn::FindInMap": [
                        "TrueFalse",
                        {
                            "Ref": "ScheduleLambdaAccount"
                        },
                        "Value"
                    ]
                },
                "trace": {
                    "Fn::FindInMap": [
                        "TrueFalse",
                        {
                            "Ref": "Trace"
                        },
                        "Value"
                    ]
                },
                "log_retention_days": {
                    "Ref": "LogRetentionDays"
                },
                "started_tags": {
                    "Ref": "StartedTags"
                },
                "stopped_tags": {
                    "Ref": "StoppedTags"
                },
                "stack_version": "v1.3.1"
            },
            "DependsOn": [
                "SchedulerLogGroup"
            ]
        }
    },
    "Outputs": {
        "AccountId": {
            "Value": {
                "Ref": "AWS::AccountId"
            },
            "Description": "Account to give access to when creating cross-account access role fro cross account scenario "
        },
        "ConfigurationTable": {
            "Value": {
                "Ref": "ConfigTable"
            },
            "Description": "Name of the DynomoDB configuration table"
        },
        "IssueSnsTopicArn": {
            "Value": {
                "Ref": "InstanceSchedulerSnsTopic"
            },
            "Description": "Topic to subscribe to for notifications of errors and warnings"
        },
        "SchedulerRoleArn": {
            "Value": {
                "Fn::GetAtt": [
                    "SchedulerRole",
                    "Arn"
                ]
            },
            "Description": "Role for the instance scheduler lambda function"
        },
        "ServiceInstanceScheduleServiceToken": {
            "Value": {
                "Fn::GetAtt": [
                    "Main",
                    "Arn"
                ]
            },
            "Description": "Arn to use as ServiceToken property for custom resource type Custom::ServiceInstanceSchedule"
        }
    }
}
STACK
  }
