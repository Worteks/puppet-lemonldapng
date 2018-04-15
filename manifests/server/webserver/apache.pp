class lemonldap::server::webserver::apache($do_soap = false,
					   $domain  = false) {
    $srvname = $::osfamily ? {
	    "RedHat" => "httpd",
	    default  => "apache2"
	}

    lemonldap::server::webserver::service { $srvname: }

    lemonldap::server::webserver::setdomain {
	$lemonldap::vars::webserver_conf:
	    domain    => $domain,
	    notify    => Service[$srvname],
	    webserver => "apache";
    }

    lemonldap::server::webserver::portalsoap {
	"apache":
	    do_soap => $do_soap,
	    notify    => Service[$srvname];
    }
}
