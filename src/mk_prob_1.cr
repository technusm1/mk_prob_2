require "benchmark"
require "./tax_util"

p TaxUtil.calc_taxes(0)
p TaxUtil.calc_taxes_v2(0)
p TaxUtil.calc_taxes_v2_precompute(0)
p TaxUtil.calc_taxes_v2_precompute_with_precompute_indices(0)

p TaxUtil.calc_taxes(1)
p TaxUtil.calc_taxes_v2(1)
p TaxUtil.calc_taxes_v2_precompute(1)
p TaxUtil.calc_taxes_v2_precompute_with_precompute_indices(1)

p TaxUtil.calc_taxes(50000.0)
p TaxUtil.calc_taxes_v2(50000.0)
p TaxUtil.calc_taxes_v2_precompute(50000.0)
p TaxUtil.calc_taxes_v2_precompute_with_precompute_indices(50000.0)

p TaxUtil.calc_taxes(85525.0)
p TaxUtil.calc_taxes_v2(85525.0)
p TaxUtil.calc_taxes_v2_precompute(85525.0)
p TaxUtil.calc_taxes_v2_precompute_with_precompute_indices(85525.0)

p TaxUtil.calc_taxes(518402.5)
p TaxUtil.calc_taxes_v2(518402.5)
p TaxUtil.calc_taxes_v2_precompute(518402.5)
p TaxUtil.calc_taxes_v2_precompute_with_precompute_indices(518402.5)

Benchmark.ips do |x|
    x.report("original") do
      TaxUtil.calc_taxes(50_000)
    end
  
    x.report("new") do
      TaxUtil.calc_taxes_v2(50_000)
    end
  
    x.report("new precompute") do
      TaxUtil.calc_taxes_v2_precompute(50_000)
    end
  
    x.report("new precompute with precompute indices") do
      TaxUtil.calc_taxes_v2_precompute_with_precompute_indices(50_000)
    end
  end
  