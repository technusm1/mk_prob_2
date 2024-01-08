require "benchmark"
require "./domain_util"
require "./domain_util_v2"


puts("strip_subdomains:")

p! DomainUtil.strip_subdomains("maps.kagi.co.uk")
p! DomainUtilv2.strip_subdomains("maps.kagi.co.uk")

p! DomainUtil.strip_subdomains("maps.kagi.com")
p! DomainUtilv2.strip_subdomains("maps.kagi.com")

p! DomainUtil.strip_subdomains("kagi.co.uk")
p! DomainUtilv2.strip_subdomains("kagi.co.uk")

p! DomainUtil.strip_subdomains("kagi.com")
p! DomainUtilv2.strip_subdomains("kagi.com")

Benchmark.ips do |x|
  x.report("original") do
    DomainUtil.strip_subdomains("maps.kagi.com")
  end

  x.report("new") do
    DomainUtilv2.strip_subdomains("maps.kagi.com")
  end
end

puts("strip_suffix:")
p! DomainUtil.strip_suffix("maps.kagi.com")
p! DomainUtilv2.strip_suffix("maps.kagi.com")

p! DomainUtil.strip_suffix("maps.kagi.co.uk")
p! DomainUtilv2.strip_suffix("maps.kagi.co.uk")

p! DomainUtil.strip_suffix("maps.kagi")
p! DomainUtilv2.strip_suffix("maps.kagi")

p! DomainUtil.strip_suffix("kagi.com")
p! DomainUtilv2.strip_suffix("kagi.com")


Benchmark.ips do |x|
  x.report("original") do
    DomainUtil.strip_suffix("maps.kagi.com")
  end

  x.report("new") do
    DomainUtilv2.strip_suffix("maps.kagi.com")
  end
end