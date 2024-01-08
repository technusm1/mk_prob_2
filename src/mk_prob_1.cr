require "benchmark"
require "./tax_util"
require "./tax_util_v2"

p TaxUtil.calc_taxes(0)
p TaxUtilv2.calc_taxes(0)
p TaxUtilv2.calc_taxes_precompute(0)
p TaxUtilv2.calc_taxes_precompute_with_precompute_indices(0)

p TaxUtil.calc_taxes(1)
p TaxUtilv2.calc_taxes(1)
p TaxUtilv2.calc_taxes_precompute(1)
p TaxUtilv2.calc_taxes_precompute_with_precompute_indices(1)

p TaxUtil.calc_taxes(50000.0)
p TaxUtilv2.calc_taxes(50000.0)
p TaxUtilv2.calc_taxes_precompute(50000.0)
p TaxUtilv2.calc_taxes_precompute_with_precompute_indices(50000.0)

p TaxUtil.calc_taxes(85525.0)
p TaxUtilv2.calc_taxes(85525.0)
p TaxUtilv2.calc_taxes_precompute(85525.0)
p TaxUtilv2.calc_taxes_precompute_with_precompute_indices(85525.0)

p TaxUtil.calc_taxes(518402.5)
p TaxUtilv2.calc_taxes(518402.5)
p TaxUtilv2.calc_taxes_precompute(518402.5)
p TaxUtilv2.calc_taxes_precompute_with_precompute_indices(518402.5)

Benchmark.ips do |x|
    x.report("original") do
      TaxUtil.calc_taxes(50_000)
    end
  
    x.report("new") do
      TaxUtilv2.calc_taxes(50_000)
    end
  
    x.report("new precompute") do
      TaxUtilv2.calc_taxes_precompute(50_000)
    end
  
    x.report("new precompute with precompute indices") do
      TaxUtilv2.calc_taxes_precompute_with_precompute_indices(50_000)
    end
  end
  