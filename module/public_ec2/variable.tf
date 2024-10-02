variable "ec2_count" {
  type        = number
  default     = 1
}

variable "ami_id" {
  type        = string
  default = "ami-0e86e20dae9224db8"
}

variable "instance_type" {
  type        = string
}

variable "subnet_id" {
  
  type        = list(string)
}

variable "sg_id" {
  type        = list(string)
}

variable "key_name" {
  type        = string

}
variable "ec2_name" {
  type        = list(string)
}


variable "associate_public_ip_address" {
  type        = bool
}

variable "alb_dns_name"{
  type = string
}
#############################################
 variable "user_data" {
    type    = string
    default = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install -y nginx
                sudo systemctl enable --now nginx
               
                sudo systemctl restart nginx
                # Create a sample index.html file
                echo "Terraform project From Private ec2<br><br>created By:yasmin mohamed <br><br>The HostName: $(hostname) " | sudo tee /var/www/html/index.html
                EOF
}
  
 

###################################
      variable "html_content" {
    type    = string
    default = <<-EOF
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Terraform Project</title>
            <style>
                body {
                    background: linear-gradient(135deg, #f6d365 0%, #fda085 100%);
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    color: #333;
                    padding: 40px;
                    margin: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    text-align: center;
                }

                .container {
                    background-color: rgba(255, 255, 255, 0.8);
                    padding: 30px;
                    border-radius: 15px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                    max-width: 600px;
                    width: 100%;
                }

                .title {
                    font-size: 26px;
                    font-weight: bold;
                    color: #2c3e50;
                    margin-bottom: 20px;
                }

                .created-by, .hostname {
                    font-size: 18px;
                    margin-bottom: 10px;
                }

                .created-by {
                    color: #8e44ad;
                }

                .hostname {
                    color: #3498db;
                    font-family: "Courier New", Courier, monospace;
                }

                footer {
                    margin-top: 20px;
                    font-size: 14px;
                    color: #7f8c8d;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <div class="title">Deploying a Secure Multi-Tier Web Application on AWS with Private Subnets and Public Load Balancer</div>
                <div class="created-by">Created By: Aya Omar</div>
                <div class="hostname">The HostName: $(hostname)</div>
                <footer>© 2024 Aya Omar. All rights reserved.</footer>
            </div>
        </body>
        </html>
    EOF
}


#######################################################

# variable "user_data" {
#     type    = string
#     default = <<-EOF
#                 #!/bin/bash
#                 sudo apt update -y
#                 sudo apt install -y nginx
#                 sudo systemctl enable --now nginx
               
#                 sudo systemctl restart nginx
#                 # Create a sample index.html file
#                 echo "Terraform project From Private ec2<br><br>created By: Aya Omar<br><br>The HostName: $(hostname) " | sudo tee /var/www/html/index.html
#                 EOF
# }