{ config, lib, pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    instock-db = {
      image = "library/mariadb";
      volumes = [
        "/data/instock-db:/var/lib/mysql"
      ];
      environment = {
        MARIADB_ROOT_PASSWORD = "root";
      };
      extraOptions = [
        "--network=host"
      ];
    };
    # instock = {
    #   image = "mayanghua/instock";
    #   ports = [ "9988" ];
    #   dependsOn = [ "instock-db" ];
    #   environment = {
    #     db_host = "localhost";
    #     db_user = "root";
    #     db_password = "root";
    #     db_database = "instock";
    #     db_port = "3306";
    #   }
    #   ;
    #   extraOptions = [
    #     "--network=host"
    #   ];
    # };
  };
}
