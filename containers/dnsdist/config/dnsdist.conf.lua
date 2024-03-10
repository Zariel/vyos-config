-- udp/tcp dns listening
setLocal("0.0.0.0:5353", {})

-- enable prometheus
webserver("0.0.0.0:8083")
setWebserverConfig({
  statsRequireAuthentication = false,
  acl = "10.42.0.0/16, 127.0.0.0/8"
})
setAPIWritable(false)

-- Local Bind
newServer({
  address = "10.5.0.3",
  pool = "bind",
  checkName = "gatewy.cbannister.casa",
  maxCheckFailures = 3,
  rise = 3,
  healthCheckMode = "auto",
  checkInterval = 1,
})

-- K8s Bind
newServer({
  address = "10.5.0.3",
  pool = "192.168.42.55",
  checkName = "ns.cbannister.xyz",
  maxCheckFailures = 3,
  rise = 3,
  healthCheckMode = "auto",
  checkInterval = 1,
})

-- Local Blocky
newServer({
  address = "10.5.0.7",
  pool = "blocky",
  healthCheckMode = "lazy",
  checkInterval = 10,
  maxCheckFailures = 3,
  lazyHealthCheckFailedInterval = 30,
  rise = 2,
  lazyHealthCheckThreshold = 30,
  lazyHealthCheckSampleSize = 100,
  lazyHealthCheckMinSampleCount = 10,
  lazyHealthCheckMode = 'TimeoutOnly',
  useClientSubnet = true,
})
-- PiHole will be given requester IP
setECSSourcePrefixV4(32)

-- CloudFlare DNS over TLS
newServer({
  address = "1.1.1.1:853",
  tls = "openssl",
  subjectName = "cloudflare-dns.com",
  validateCertificates = true,
  checkInterval = 10,
  checkTimeout = 2000,
  pool = "cloudflare"
})
newServer({
  address = "1.0.0.1:853",
  tls = "openssl",
  subjectName = "cloudflare-dns.com",
  validateCertificates = true,
  checkInterval = 10,
  checkTimeout = 2000,
  pool = "cloudflare"
})

-- Enable caching
pc = newPacketCache(1000000, {
  maxTTL = 86400,
  minTTL = 0,
  temporaryFailureTTL = 60,
  staleTTL = 60,
  dontAge = false
})
-- getPool("blocky"):setCache(pc)
getPool("cloudflare"):setCache(pc)

-- addAction(AllRule(), LogAction("", false, false, true, false, false))
-- addResponseAction(AllRule(), LogResponseAction("", false, true, false, false))

addAction("192.168.2.0/24", PoolAction("blocky"))     -- guest vlan
addAction("192.168.2.0/24", DropAction())             -- stop processing

-- this will send this domain to the bind server
addAction('cbannister.xyz', PoolAction('k8s-bind'))
addAction('cbannister.casa', PoolAction('bind'))
addAction('unifi', PoolAction('bind'))

addAction("10.1.3.1/24", PoolAction("blocky"))      -- iot
addAction("10.1.0.0/24", PoolAction("cloudflare"))  -- lan
addAction("10.1.1.0/24", PoolAction("blocky"))      -- servers vlan
addAction("10.1.2.0/24", PoolAction("blocky"))      -- trusted vlan
addAction("10.1.3.0/24", PoolAction("blocky"))      -- iot vlan
