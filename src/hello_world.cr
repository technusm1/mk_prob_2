require "benchmark"


BRACKETS = {
  "percent" => [0.10, 0.12, 0.22, 0.24, 0.32, 0.35, 0.37],
  "single"  => [0, 9875, 40125, 85525, 163300, 207350, 518400],
  "married" => [0, 19750, 80250, 171050, 326600, 414700, 622050],
  "hoh"     => [0, 14100, 53700, 85500, 163300, 207350, 518400],
}

def calc_taxes(income, status = "single")
  bracket = BRACKETS[status]
  percentages = BRACKETS["percent"]
  index = bracket.index { |high| income < high } || bracket.size
  total_taxes = 0
  bracket.first(index).zip(percentages.first(index)).reverse.each do |lower, percent|
    diff_to_lower = (income - lower)
    total_taxes += diff_to_lower * percent
    income -= diff_to_lower
  end
  total_taxes
end

BRACKETS_NEW = {
  percent: {0.10, 0.12, 0.22, 0.24, 0.32, 0.35, 0.37},
  single: {0, 9875, 40125, 85525, 163300, 207350, 518400},
  married: {0, 19750, 80250, 171050, 326600, 414700, 622050},
  hoh: {0, 14100, 53700, 85500, 163300, 207350, 518400},
}

PRECOMPUTED_TAXES = {
  single: BRACKETS_NEW[:single].map { |income| calc_taxes_v2(income, :single) },
  married: BRACKETS_NEW[:married].map { |income| calc_taxes_v2(income, :married) },
  hoh: BRACKETS_NEW[:hoh].map { |income| calc_taxes_v2(income, :hoh) },
}

def calc_taxes_v2(income, status = :single)
  bracket = BRACKETS_NEW[status]
  percentages = BRACKETS_NEW[:percent]

  index = bracket.index { |high| income < high } || bracket.size

  total_taxes = 0.0
  (index - 1).downto(0) do |i|
    diff_to_lower = income - bracket[i]
    total_taxes += diff_to_lower * percentages[i]
    income -= diff_to_lower
  end
  total_taxes
end

def find_index_in_single(income)
  if income > 518400
    6
  elsif income >= 207350
    5
  elsif income >= 163300
    4
  elsif income >= 85525
    3
  elsif income >= 40125
    2
  elsif income >= 9875
    1
  else
    0
  end
end

def find_index_in_married(income)
  if income > 622050
    6
  elsif income >= 414700
    5
  elsif income >= 326600
    4
  elsif income >= 171050
    3
  elsif income >= 80250
    2
  elsif income >= 19750
    1
  else
    0
  end
end

def find_index_in_hoh(income)
  if income > 518400
    6
  elsif income >= 207350
    5
  elsif income >= 163300
    4
  elsif income >= 85500
    3
  elsif income >= 53700
    2
  elsif income >= 14100
    1
  else
    0
  end
end

def calc_taxes_v2_precompute(income, status = :single)
  bracket = BRACKETS_NEW[status]
  percentages = BRACKETS_NEW[:percent]
  index = bracket.rindex { |high| income >= high } || 0
  (income - bracket[index]) * percentages[index] + PRECOMPUTED_TAXES[status][index]
end

def calc_taxes_v2_precompute_with_precompute_indices(income, status = :single)
  bracket = BRACKETS_NEW[status]
  percentages = BRACKETS_NEW[:percent]
  index = 0
  case status
  when :single
    index = find_index_in_single(income)
  when :married
    index = find_index_in_married(income)
  when :hoh
    index = find_index_in_hoh(income)
  end
  (income - bracket[index]) * percentages[index] + PRECOMPUTED_TAXES[status][index]
end

p calc_taxes(0)
p calc_taxes_v2(0)
p calc_taxes_v2_precompute(0)
p calc_taxes_v2_precompute_with_precompute_indices(0)

p calc_taxes(1)
p calc_taxes_v2(1)
p calc_taxes_v2_precompute(1)
p calc_taxes_v2_precompute_with_precompute_indices(1)

p calc_taxes(50000.0)
p calc_taxes_v2(50000.0)
p calc_taxes_v2_precompute(50000.0)
p calc_taxes_v2_precompute_with_precompute_indices(50000.0)

p calc_taxes(85525.0)
p calc_taxes_v2(85525.0)
p calc_taxes_v2_precompute(85525.0)
p calc_taxes_v2_precompute_with_precompute_indices(85525.0)

p calc_taxes(518402.5)
p calc_taxes_v2(518402.5)
p calc_taxes_v2_precompute(518402.5)
p calc_taxes_v2_precompute_with_precompute_indices(518402.5)

Benchmark.ips do |x|
  x.report("original") do
    calc_taxes(50_000)
  end

  x.report("new") do
    calc_taxes_v2(50_000)
  end

  x.report("new precompute") do
    calc_taxes_v2_precompute(50_000)
  end

  x.report("new precompute with precompute indices") do
    calc_taxes_v2_precompute_with_precompute_indices(50_000)
  end
end