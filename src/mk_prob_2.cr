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

puts("\n\n")

puts("strip_suffix:")
p! DomainUtil.strip_suffix("maps.kagi.com")
p! DomainUtilv2.strip_suffix("maps.kagi.com")

p! DomainUtil.strip_suffix("maps.kagi.co.uk")
p! DomainUtilv2.strip_suffix("maps.kagi.co.uk")

p! DomainUtil.strip_suffix("maps.kagi")
p! DomainUtilv2.strip_suffix("maps.kagi")

p! DomainUtil.strip_suffix("kagi.com")
p! DomainUtilv2.strip_suffix("kagi.com")

# We run these to make sure the caches are populated
# before we start benchmarking. This ensures that network
# latency doesn't affect the results.
DomainUtil.update_tlds
DomainUtil.update_suffixes
DomainUtilv2.update_tlds
DomainUtilv2.update_suffixes

puts("\n\n")

puts("Benchmarking: strip_subdomains")
Benchmark.ips do |x|
  x.report("original strip_subdomains") do
    DomainUtil.strip_subdomains("maps.kagi.com")
  end

  x.report("new strip_subdomains") do
    DomainUtilv2.strip_subdomains("maps.kagi.com")
  end
end

puts("\n\n")

puts("Benchmarking: strip_suffix")
Benchmark.ips do |x|
  x.report("original strip_suffix") do
    DomainUtil.strip_suffix("maps.kagi.com")
  end

  x.report("new strip_suffix") do
    DomainUtilv2.strip_suffix("maps.kagi.com")
  end
end