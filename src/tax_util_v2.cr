# This module contains the code for calculating taxes.
# Author: Maheep Kumar (technusm1)
module TaxUtilv2

  # BRACKETS_NEW uses tuples instead of arrays and namedtuple instead of hash
  # Update find_index_in_* functions if BRACKETS_NEW is updated
  BRACKETS_NEW = {
    percent: {0.10, 0.12, 0.22, 0.24, 0.32, 0.35, 0.37},
    single:  {0, 9875, 40125, 85525, 163300, 207350, 518400},
    married: {0, 19750, 80250, 171050, 326600, 414700, 622050},
    hoh:     {0, 14100, 53700, 85500, 163300, 207350, 518400},
  }

  # We are precomputing the taxes for each bracket limits
  PRECOMPUTED_TAXES = {
    single:  BRACKETS_NEW[:single].map { |income| calc_taxes(income, :single) },
    married: BRACKETS_NEW[:married].map { |income| calc_taxes(income, :married) },
    hoh:     BRACKETS_NEW[:hoh].map { |income| calc_taxes(income, :hoh) },
  }

  # Initial implementation (faster than original code):
  # - using symbols instead of strings
  # - using a simple loop instead of zip processing multiple arrays
  def self.calc_taxes(income, status = :single)
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

  # For a given income, we are precomputing the index of the bracket single
  # This function needs to be updated if SINGLE bracket is updated
  private def self.find_index_in_single(income)
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

  # For a given income, we are precomputing the index of the bracket married
  # This function needs to be updated if MARRIED bracket is updated
  private def self.find_index_in_married(income)
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

  # For a given income, we are precomputing the index of the bracket hoh
  # This function needs to be updated if HOH bracket is updated
  private def self.find_index_in_hoh(income)
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

  # Implementation with precomputed taxes.
  # Works better than our initial implementation,
  # since we are using PRECOMPUTED_TAXES to improve
  # the performance of tax calculation step
  # NOTE: I tried using binary search to find the index of the bracket,
  # but the performance was slower than the current implementation.
  # Could be that the bracket is too small for binary search to be effective.
  def self.calc_taxes_precompute(income, status = :single)
    bracket = BRACKETS_NEW[status]
    percentages = BRACKETS_NEW[:percent]
    index = bracket.rindex { |high| income >= high } || 0
    (income - bracket[index]) * percentages[index] + PRECOMPUTED_TAXES[status][index]
  end

  # Implementation with precomputed taxes and precomputed indices.
  # Works better than our initial implementation, and the precompute implementation above
  # Since we are using precomputed indices, we can get rid of the rindex call completely
  # The cost comes in terms of code maintainability, since we need to update the find_index_in_* functions
  # if the brackets are updated. This is a tradeoff we are making for performance.
  def self.calc_taxes_precompute_with_precompute_indices(income, status = :single)
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
end
