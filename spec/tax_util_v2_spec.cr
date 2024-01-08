require "./spec_helper"

describe "TaxUtilv2" do
    describe ".calc_taxes" do
        it "calculates taxes correctly for single status" do
            TaxUtilv2.calc_taxes(10000, :single).should eq(TaxUtil.calc_taxes(10000, "single"))
            TaxUtilv2.calc_taxes(50000, :single).should eq(TaxUtil.calc_taxes(50000, "single"))
            TaxUtilv2.calc_taxes(100000, :single).should eq(TaxUtil.calc_taxes(100000, "single"))
        end

        it "calculates taxes correctly for married status" do
            TaxUtilv2.calc_taxes(10000, :married).should eq(TaxUtil.calc_taxes(10000, "married"))
            TaxUtilv2.calc_taxes(50000, :married).should eq(TaxUtil.calc_taxes(50000, "married"))
            TaxUtilv2.calc_taxes(100000, :married).should eq(TaxUtil.calc_taxes(100000, "married"))
        end

        it "calculates taxes correctly for hoh status" do
            TaxUtilv2.calc_taxes(10000, :hoh).should eq(TaxUtil.calc_taxes(10000, "hoh"))
            TaxUtilv2.calc_taxes(50000, :hoh).should eq(TaxUtil.calc_taxes(50000, "hoh"))
            TaxUtilv2.calc_taxes(100000, :hoh).should eq(TaxUtil.calc_taxes(100000, "hoh"))
        end
    end

    describe ".calc_taxes_precompute" do
        it "calculates taxes correctly for single status" do
            TaxUtilv2.calc_taxes_precompute(10000, :single).should eq(TaxUtil.calc_taxes(10000, "single"))
            TaxUtilv2.calc_taxes_precompute(50000, :single).should eq(TaxUtil.calc_taxes(50000, "single"))
            TaxUtilv2.calc_taxes_precompute(100000, :single).should eq(TaxUtil.calc_taxes(100000, "single"))
        end

        it "calculates taxes correctly for married status" do
            TaxUtilv2.calc_taxes_precompute(10000, :married).should eq(TaxUtil.calc_taxes(10000, "married"))
            TaxUtilv2.calc_taxes_precompute(50000, :married).should eq(TaxUtil.calc_taxes(50000, "married"))
            TaxUtilv2.calc_taxes_precompute(100000, :married).should eq(TaxUtil.calc_taxes(100000, "married"))
        end

        it "calculates taxes correctly for hoh status" do
            TaxUtilv2.calc_taxes_precompute(10000, :hoh).should eq(TaxUtil.calc_taxes(10000, "hoh"))
            TaxUtilv2.calc_taxes_precompute(50000, :hoh).should eq(TaxUtil.calc_taxes(50000, "hoh"))
            TaxUtilv2.calc_taxes_precompute(100000, :hoh).should eq(TaxUtil.calc_taxes(100000, "hoh"))
        end
    end

    describe ".calc_taxes_precompute_with_precompute_indices" do
        it "calculates taxes correctly for single status" do
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(10000, :single).should eq(TaxUtil.calc_taxes(10000, "single"))
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(50000, :single).should eq(TaxUtil.calc_taxes(50000, "single"))
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(100000, :single).should eq(TaxUtil.calc_taxes(100000, "single"))
        end

        it "calculates taxes correctly for married status" do
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(10000, :married).should eq(TaxUtil.calc_taxes(10000, "married"))
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(50000, :married).should eq(TaxUtil.calc_taxes(50000, "married"))
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(100000, :married).should eq(TaxUtil.calc_taxes(100000, "married"))
        end

        it "calculates taxes correctly for hoh status" do
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(10000, :hoh).should eq(TaxUtil.calc_taxes(10000, "hoh"))
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(50000, :hoh).should eq(TaxUtil.calc_taxes(50000, "hoh"))
            TaxUtilv2.calc_taxes_precompute_with_precompute_indices(100000, :hoh).should eq(TaxUtil.calc_taxes(100000, "hoh"))
        end
    end
end
