require File.join(File.dirname(__FILE__),"spec_helper.rb")
require 'yaml'

describe Launchy::Application do
    before(:each) do
        yml = YAML::load(IO.read(File.join(File.dirname(__FILE__),"tattle-host-os.yml")))
        @host_os = yml['host_os']
        @app = Launchy::Application.new
    end

    YAML::load(IO.read(File.join(File.dirname(__FILE__), "tattle-host-os.yml")))['host_os'].keys.sort.each do |os|
      it "#{os} should be a found os" do
        Launchy::Application::KNOWN_OS_FAMILIES.should include(@app.my_os_family(os))
      end
    end
    
    it "should not find os of 'dos'" do
        @app.my_os_family('dos').should == :unknown
    end
    
    it "my os should have a value" do
        @app.my_os.should_not == ''
        @app.my_os.should_not == nil
    end 
    
    it "should find open" do    
        @app.find_executable('open').should == "/usr/bin/open"
    end
    
    it "should not find app xyzzy" do
        @app.find_executable('xyzzy').should == nil
    end
    
    it "should find the correct class to launch an ftp url" do
        Launchy::Application.find_application_class_for("ftp://ftp.ruby-lang.org/pub/ruby/").should == Launchy::Browser
    end
    
    it "knows when it cannot find an application class" do
        Launchy::Application.find_application_class_for("xyzzy:stuff,things").should == nil
    end
    
    it "allows for environmental override of host_os" do
        ENV["LAUNCHY_HOST_OS"] = "hal-9000"
        Launchy::Application.my_os.should == "hal-9000"
        ENV["LAUNCHY_HOST_OS"] = nil
    end
    
    it "can detect the desktop environment of a *nix machien" do
        @app.nix_desktop_environment.should == :generic

        { "KDE_FULL_SESSION" => :kde,
          "KDE_SESSION_UID"  => :kde,
          "GNOME_DESKTOP_SESSION_ID" => :gnome }.each_pair do |k,v|
            ENV[k] = "launchy-test"
            Launchy::Application.new.nix_desktop_environment.should == v
            ENV[k] = nil
        end
    end
end
