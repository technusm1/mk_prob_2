## Benchmarking Results
Below are some benchmarking results done on my MacBook Pro 2019 (16-inch) with the following specs:
- 2.6 GHz 6-Core Intel Core i7
- 16 GB 2667 MHz DDR4
- OS: macOS Sonoma 14.2

### For Problem - A
```
TaxUtil.calc_taxes(0) # => 0.0
TaxUtilv2.calc_taxes(0) # => 0.0
TaxUtilv2.calc_taxes_precompute(0) # => 0.0
TaxUtilv2.calc_taxes_precompute_with_precompute_indices(0) # => 0.0

TaxUtil.calc_taxes(1) # => 0.1
TaxUtilv2.calc_taxes(1) # => 0.1
TaxUtilv2.calc_taxes_precompute(1) # => 0.1
TaxUtilv2.calc_taxes_precompute_with_precompute_indices(1) # => 0.1

TaxUtil.calc_taxes(50000.0) # => 6790.0
TaxUtilv2.calc_taxes(50000.0) # => 6790.0
TaxUtilv2.calc_taxes_precompute(50000.0) # => 6790.0
TaxUtilv2.calc_taxes_precompute_with_precompute_indices(50000.0) # => 6790.0

TaxUtil.calc_taxes(85525.0) # => 14605.5
TaxUtilv2.calc_taxes(85525.0) # => 14605.5
TaxUtilv2.calc_taxes_precompute(85525.0) # => 14605.5
TaxUtilv2.calc_taxes_precompute_with_precompute_indices(85525.0) # => 14605.5

TaxUtil.calc_taxes(518402.5) # => 156235.925
TaxUtilv2.calc_taxes(518402.5) # => 156235.925
TaxUtilv2.calc_taxes_precompute(518402.5) # => 156235.925
TaxUtilv2.calc_taxes_precompute_with_precompute_indices(518402.5) # => 156235.925

Benchmarking...
                              original   5.46M (183.10ns) (± 1.25%)  337B/op  150.98× slower
                                   new  41.79M ( 23.93ns) (± 1.77%)  0.0B/op   19.73× slower
                        new precompute 196.66M (  5.08ns) (± 4.76%)  0.0B/op    4.19× slower
new precompute with precompute indices 824.58M (  1.21ns) (± 3.63%)  0.0B/op         fastest

```

### For Problem - B
```
strip_subdomains:
DomainUtil.strip_subdomains("maps.kagi.co.uk") # => "kagi.co.uk"
DomainUtilv2.strip_subdomains("maps.kagi.co.uk") # => "kagi.co.uk"
DomainUtil.strip_subdomains("maps.kagi.com") # => "kagi.com"
DomainUtilv2.strip_subdomains("maps.kagi.com") # => "kagi.com"
DomainUtil.strip_subdomains("kagi.co.uk") # => "kagi.co.uk"
DomainUtilv2.strip_subdomains("kagi.co.uk") # => "kagi.co.uk"
DomainUtil.strip_subdomains("kagi.com") # => "kagi.com"
DomainUtilv2.strip_subdomains("kagi.com") # => "kagi.com"


strip_suffix:
DomainUtil.strip_suffix("maps.kagi.com") # => "maps.kagi"
DomainUtilv2.strip_suffix("maps.kagi.com") # => "maps.kagi"
DomainUtil.strip_suffix("maps.kagi.co.uk") # => "maps.kagi"
DomainUtilv2.strip_suffix("maps.kagi.co.uk") # => "maps.kagi"
DomainUtil.strip_suffix("maps.kagi") # => "maps.kagi"
DomainUtilv2.strip_suffix("maps.kagi") # => "maps.kagi"
DomainUtil.strip_suffix("kagi.com") # => "kagi"
DomainUtilv2.strip_suffix("kagi.com") # => "kagi"


Benchmarking: strip_subdomains
original strip_subdomains   1.79M (558.69ns) (± 1.90%)  560B/op   4.01× slower
     new strip_subdomains   7.18M (139.02ns) (± 1.95%)  129B/op        fastest


Benchmarking: strip_suffix
original strip_suffix   1.78M (562.11ns) (± 4.12%)  560B/op   4.00× slower
     new strip_suffix   7.12M (140.53ns) (± 2.07%)  129B/op        fastest
```