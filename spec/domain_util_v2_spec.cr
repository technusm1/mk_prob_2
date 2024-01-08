require "./spec_helper"

describe "DomainUtilv2" do
    before_all do
        DomainUtilv2.update_tlds
        DomainUtilv2.update_suffixes
    end

    describe ".strip_subdomains" do
        it "returns the domain name without subdomains" do
            DomainUtilv2.strip_subdomains("www.example.com").should eq("example.com")
            DomainUtilv2.strip_subdomains("subdomain.example.co.uk").should eq("example.co.uk")
        end

        it "returns the domain name without subdomains when tld_only is true" do
            DomainUtilv2.strip_subdomains("www.example.com", true).should eq("example.com")
            DomainUtilv2.strip_subdomains("subdomain.example.co.uk", true).should eq("co.uk")
        end
    end

    describe ".strip_suffix" do
        it "returns the hostname without the domain extension" do
            DomainUtilv2.strip_suffix("www.example.com").should eq("www.example")
            DomainUtilv2.strip_suffix("subdomain.example.co.uk").should eq("subdomain.example")
        end

        it "returns the hostname without the domain extension when tld_only is true" do
            DomainUtilv2.strip_suffix("www.example.com", true).should eq("www.example")
            DomainUtilv2.strip_suffix("subdomain.example.co.uk", true).should eq("subdomain.example")
        end
    end
end
