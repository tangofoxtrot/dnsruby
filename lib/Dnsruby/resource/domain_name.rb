#--
#Copyright 2007 Nominet UK
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License. 
#You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0 
#
#Unless required by applicable law or agreed to in writing, software 
#distributed under the License is distributed on an "AS IS" BASIS, 
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
#See the License for the specific language governing permissions and 
#limitations under the License.
#++
module Dnsruby
  class RR
    # Superclass for RR's which have an additional domain name in the data section.
    class DomainName < RR
      # The domain name in the RR data section.
      attr_reader :domainname
      
      def set_domain_name(newname)
        #        if (!(newname.kind_of?Name))
        @domainname=Name.create(newname)
        #       else
        #        @domainname = newname
        #     end
      end
      
      alias domainname= set_domain_name
      
      def from_hash(hash) #:nodoc: all
        set_domain_name(hash[:domainname])
      end
      
      def from_data(data) #:nodoc: all
        @domainname = data
      end
      
      def from_string(input) #:nodoc: all
        set_domain_name(input)
      end
      
      def rdata_to_string #:nodoc: all
        return @domainname.to_s
      end
      
      def encode_rdata(msg, canonical=false) #:nodoc: all
        msg.put_name(@domainname, canonical)
      end
      
      def self.decode_rdata(msg) #:nodoc: all
        return self.new(msg.get_name)
      end
    end
  end
end
