################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################

module CZMQ
  module FFI
    
    # high-level socket API that hides libzmq contexts and sockets
    class Zsock
      class DestroyedError < RuntimeError; end
      
      # Boilerplate for self pointer, initializer, and finalizer
      class << self
        alias :__new :new
      end
      def initialize ptr, finalize=true
        @ptr = ptr
        if @ptr.null?
          @ptr = nil # Remove null pointers so we don't have to test for them.
        elsif finalize
          @finalizer = self.class.send :create_finalizer_for, @ptr
          ObjectSpace.define_finalizer self, @finalizer
        end
      end
      def self.create_finalizer_for ptr
        Proc.new do
          ptr_ptr = ::FFI::MemoryPointer.new :pointer
          ptr_ptr.write_pointer ptr
          ::CZMQ::FFI.zsock_destroy ptr_ptr
        end
      end
      def null?
        !@ptr or ptr.null?
      end
      # Return internal pointer
      def __ptr
        raise DestroyedError unless @ptr
        @ptr
      end
      # Nullify internal pointer and return pointer pointer
      def __ptr_give_ref
        raise DestroyedError unless @ptr
        ptr_ptr = ::FFI::MemoryPointer.new :pointer
        ptr_ptr.write_pointer @ptr
        ObjectSpace.undefine_finalizer self if @finalizer
        @finalizer = nil
        @ptr = nil
        ptr_ptr
      end
      
      # Create a new socket. Returns the new socket, or NULL if the new socket
      # could not be created. Note that the symbol zsock_new (and other       
      # constructors/destructors for zsock) are redirected to the *_checked   
      # variant, enabling intelligent socket leak detection. This can have    
      # performance implications if you use a LOT of sockets. To turn off this
      # redirection behaviour, define ZSOCK_NOCHECK.                          
      def self.new type
        type = Integer(type)
        ptr = ::CZMQ::FFI.zsock_new type
        
        __new ptr
      end
      
      # Destroy the socket. You must use this for any socket created via the
      # zsock_new method.                                                   
      def destroy
        return unless @ptr
        self_p = __ptr_give_ref
        result = ::CZMQ::FFI.zsock_destroy self_p
        result
      end
      
      # Create a PUB socket. Default action is bind.
      def self.new_pub endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_pub endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a SUB socket, and optionally subscribe to some prefix string. Default
      # action is connect.                                                          
      def self.new_sub endpoint, subscribe
        endpoint = String(endpoint)
        subscribe = String(subscribe)
        result = ::CZMQ::FFI.zsock_new_sub endpoint, subscribe
        result = Zsock.__new result, false
        result
      end
      
      # Create a REQ socket. Default action is connect.
      def self.new_req endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_req endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a REP socket. Default action is bind.
      def self.new_rep endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_rep endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a DEALER socket. Default action is connect.
      def self.new_dealer endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_dealer endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a ROUTER socket. Default action is bind.
      def self.new_router endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_router endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a PUSH socket. Default action is connect.
      def self.new_push endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_push endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a PULL socket. Default action is bind.
      def self.new_pull endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_pull endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create an XPUB socket. Default action is bind.
      def self.new_xpub endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_xpub endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create an XSUB socket. Default action is connect.
      def self.new_xsub endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_xsub endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a PAIR socket. Default action is connect.
      def self.new_pair endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_pair endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Create a STREAM socket. Default action is connect.
      def self.new_stream endpoint
        endpoint = String(endpoint)
        result = ::CZMQ::FFI.zsock_new_stream endpoint
        result = Zsock.__new result, false
        result
      end
      
      # Bind a socket to a formatted endpoint. For tcp:// endpoints, supports   
      # ephemeral ports, if you specify the port number as "*". By default      
      # zsock uses the IANA designated range from C000 (49152) to FFFF (65535). 
      # To override this range, follow the "*" with "[first-last]". Either or   
      # both first and last may be empty. To bind to a random port within the   
      # range, use "!" in place of "*".                                         
      #                                                                         
      # Examples:                                                               
      #     tcp://127.0.0.1:*           bind to first free port from C000 up    
      #     tcp://127.0.0.1:!           bind to random port from C000 to FFFF   
      #     tcp://127.0.0.1:*[60000-]   bind to first free port from 60000 up   
      #     tcp://127.0.0.1:![-60000]   bind to random port from C000 to 60000  
      #     tcp://127.0.0.1:![55000-55999]                                      
      #                                 bind to random port from 55000 to 55999 
      #                                                                         
      # On success, returns the actual port number used, for tcp:// endpoints,  
      # and 0 for other transports. On failure, returns -1. Note that when using
      # ephemeral ports, a port may be reused by different services without     
      # clients being aware. Protocols that run on ephemeral ports should take  
      # this into account.                                                      
      def bind format, result
        raise DestroyedError unless @ptr
        format = String(format)
        result = ::CZMQ::FFI.zsock_bind @ptr, format, result
        result
      end
      
      # Returns last bound endpoint, if any.
      def endpoint
        raise DestroyedError unless @ptr
        result = ::CZMQ::FFI.zsock_endpoint @ptr
        result
      end
      
      # Unbind a socket from a formatted endpoint.                     
      # Returns 0 if OK, -1 if the endpoint was invalid or the function
      # isn't supported.                                               
      def unbind format, result
        raise DestroyedError unless @ptr
        format = String(format)
        result = ::CZMQ::FFI.zsock_unbind @ptr, format, result
        result
      end
      
      # Connect a socket to a formatted endpoint        
      # Returns 0 if OK, -1 if the endpoint was invalid.
      def connect format, result
        raise DestroyedError unless @ptr
        format = String(format)
        result = ::CZMQ::FFI.zsock_connect @ptr, format, result
        result
      end
      
      # Disconnect a socket from a formatted endpoint                  
      # Returns 0 if OK, -1 if the endpoint was invalid or the function
      # isn't supported.                                               
      def disconnect format, result
        raise DestroyedError unless @ptr
        format = String(format)
        result = ::CZMQ::FFI.zsock_disconnect @ptr, format, result
        result
      end
      
      # Attach a socket to zero or more endpoints. If endpoints is not null,    
      # parses as list of ZeroMQ endpoints, separated by commas, and prefixed by
      # '@' (to bind the socket) or '>' (to attach the socket). Returns 0 if all
      # endpoints were valid, or -1 if there was a syntax error. If the endpoint
      # does not start with '@' or '>', the serverish argument defines whether  
      # it is used to bind (serverish = true) or connect (serverish = false).   
      def attach endpoints, serverish
        raise DestroyedError unless @ptr
        endpoints = String(endpoints)
        serverish = !(0==serverish||!serverish) # boolean
        result = ::CZMQ::FFI.zsock_attach @ptr, endpoints, serverish
        result
      end
      
      # Returns socket type as printable constant string.
      def type_str
        raise DestroyedError unless @ptr
        result = ::CZMQ::FFI.zsock_type_str @ptr
        result
      end
      
      # Send a 'picture' message to the socket (or actor). The picture is a   
      # string that defines the type of each frame. This makes it easy to send
      # a complex multiframe message in one call. The picture can contain any 
      # of these characters, each corresponding to one or two arguments:      
      #                                                                       
      #     i = int (signed)                                                  
      #     1 = uint8_t                                                       
      #     2 = uint16_t                                                      
      #     4 = uint32_t                                                      
      #     8 = uint64_t                                                      
      #     b = byte *, size_t (2 arguments)                                  
      #     c = zchunk_t *                                                    
      #     f = zframe_t *                                                    
      #     h = zhashx_t *                                                    
      #     p = void * (sends the pointer value, only meaningful over inproc) 
      #     m = zmsg_t * (sends all frames in the zmsg)                       
      #     z = sends zero-sized frame (0 arguments)                          
      #     u = uint (deprecated)                                             
      #                                                                       
      # Note that s, b, c, and f are encoded the same way and the choice is   
      # offered as a convenience to the sender, which may or may not already  
      # have data in a zchunk or zframe. Does not change or take ownership of 
      # any arguments. Returns 0 if successful, -1 if sending failed for any  
      # reason.                                                               
      def send picture, result
        raise DestroyedError unless @ptr
        picture = String(picture)
        result = ::CZMQ::FFI.zsock_send @ptr, picture, result
        result
      end
      
      # Send a 'picture' message to the socket (or actor). This is a va_list 
      # version of zsock_send (), so please consult its documentation for the
      # details.                                                             
      def vsend picture, argptr
        raise DestroyedError unless @ptr
        picture = String(picture)
        result = ::CZMQ::FFI.zsock_vsend @ptr, picture, argptr
        result
      end
      
      # Receive a 'picture' message to the socket (or actor). See zsock_send for
      # the format and meaning of the picture. Returns the picture elements into
      # a series of pointers as provided by the caller:                         
      #                                                                         
      #     i = int * (stores signed integer)                                   
      #     4 = uint32_t * (stores 32-bit unsigned integer)                     
      #     8 = uint64_t * (stores 64-bit unsigned integer)                     
      #     s = char ** (allocates new string)                                  
      #     b = byte **, size_t * (2 arguments) (allocates memory)              
      #     c = zchunk_t ** (creates zchunk)                                    
      #     f = zframe_t ** (creates zframe)                                    
      #     p = void ** (stores pointer)                                        
      #     h = zhashx_t ** (creates zhashx)                                    
      #     m = zmsg_t ** (creates a zmsg with the remaing frames)              
      #     z = null, asserts empty frame (0 arguments)                         
      #     u = uint * (stores unsigned integer, deprecated)                    
      #                                                                         
      # Note that zsock_recv creates the returned objects, and the caller must  
      # destroy them when finished with them. The supplied pointers do not need 
      # to be initialized. Returns 0 if successful, or -1 if it failed to recv  
      # a message, in which case the pointers are not modified. When message    
      # frames are truncated (a short message), sets return values to zero/null.
      # If an argument pointer is NULL, does not store any value (skips it).    
      # An 'n' picture matches an empty frame; if the message does not match,   
      # the method will return -1.                                              
      def recv picture, result
        raise DestroyedError unless @ptr
        picture = String(picture)
        result = ::CZMQ::FFI.zsock_recv @ptr, picture, result
        result
      end
      
      # Receive a 'picture' message from the socket (or actor). This is a    
      # va_list version of zsock_recv (), so please consult its documentation
      # for the details.                                                     
      def vrecv picture, argptr
        raise DestroyedError unless @ptr
        picture = String(picture)
        result = ::CZMQ::FFI.zsock_vrecv @ptr, picture, argptr
        result
      end
      
      # Send a binary encoded 'picture' message to the socket (or actor). This 
      # method is similar to zsock_send, except the arguments are encoded in a 
      # binary format that is compatible with zproto, and is designed to reduce
      # memory allocations. The pattern argument is a string that defines the  
      # type of each argument. Supports these argument types:                  
      #                                                                        
      #  pattern    C type                  zproto type:                       
      #     1       uint8_t                 type = "number" size = "1"         
      #     2       uint16_t                type = "number" size = "2"         
      #     4       uint32_t                type = "number" size = "3"         
      #     8       uint64_t                type = "number" size = "4"         
      #     s       char *, 0-255 chars     type = "string"                    
      #     S       char *, 0-2^32-1 chars  type = "longstr"                   
      #     c       zchunk_t *              type = "chunk"                     
      #     f       zframe_t *              type = "frame"                     
      #     m       zmsg_t *                type = "msg"                       
      #     p       void *, sends pointer value, only over inproc              
      #                                                                        
      # Does not change or take ownership of any arguments. Returns 0 if       
      # successful, -1 if sending failed for any reason.                       
      def bsend picture, result
        raise DestroyedError unless @ptr
        picture = String(picture)
        result = ::CZMQ::FFI.zsock_bsend @ptr, picture, result
        result
      end
      
      # Receive a binary encoded 'picture' message from the socket (or actor).  
      # This method is similar to zsock_recv, except the arguments are encoded  
      # in a binary format that is compatible with zproto, and is designed to   
      # reduce memory allocations. The pattern argument is a string that defines
      # the type of each argument. See zsock_bsend for the supported argument   
      # types. All arguments must be pointers; this call sets them to point to  
      # values held on a per-socket basis. Do not modify or destroy the returned
      # values. Returns 0 if successful, or -1 if it failed to read a message.  
      def brecv picture, result
        raise DestroyedError unless @ptr
        picture = String(picture)
        result = ::CZMQ::FFI.zsock_brecv @ptr, picture, result
        result
      end
      
      # Set socket to use unbounded pipes (HWM=0); use this in cases when you are
      # totally certain the message volume can fit in memory. This method works  
      # across all versions of ZeroMQ. Takes a polymorphic socket reference.     
      def set_unbounded
        raise DestroyedError unless @ptr
        result = ::CZMQ::FFI.zsock_set_unbounded @ptr
        result
      end
      
      # Send a signal over a socket. A signal is a short message carrying a   
      # success/failure code (by convention, 0 means OK). Signals are encoded 
      # to be distinguishable from "normal" messages. Accepts a zock_t or a   
      # zactor_t argument, and returns 0 if successful, -1 if the signal could
      # not be sent. Takes a polymorphic socket reference.                    
      def signal status
        raise DestroyedError unless @ptr
        result = ::CZMQ::FFI.zsock_signal @ptr, status
        result
      end
      
      # Wait on a signal. Use this to coordinate between threads, over pipe  
      # pairs. Blocks until the signal is received. Returns -1 on error, 0 or
      # greater on success. Accepts a zsock_t or a zactor_t as argument.     
      # Takes a polymorphic socket reference.                                
      def wait
        raise DestroyedError unless @ptr
        result = ::CZMQ::FFI.zsock_wait @ptr
        result
      end
      
      # If there is a partial message still waiting on the socket, remove and    
      # discard it. This is useful when reading partial messages, to get specific
      # message types.                                                           
      def flush
        raise DestroyedError unless @ptr
        result = ::CZMQ::FFI.zsock_flush @ptr
        result
      end
      
      # Probe the supplied object, and report if it looks like a zsock_t.
      # Takes a polymorphic socket reference.                            
      def self.is self
        result = ::CZMQ::FFI.zsock_is self
        result
      end
      
      # Probe the supplied reference. If it looks like a zsock_t instance, return
      # the underlying libzmq socket handle; else if it looks like a file        
      # descriptor, return NULL; else if it looks like a libzmq socket handle,   
      # return the supplied value. Takes a polymorphic socket reference.         
      def self.resolve self
        result = ::CZMQ::FFI.zsock_resolve self
        result
      end
      
      # Self test of this class
      def self.test verbose
        verbose = !(0==verbose||!verbose) # boolean
        result = ::CZMQ::FFI.zsock_test verbose
        result
      end
    end
    
  end
end

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  Please refer to the README for information about making permanent changes.  #
################################################################################
