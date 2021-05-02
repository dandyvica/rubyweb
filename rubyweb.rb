# A simple WEB server targeted at verifying client requests
# start it with: ruby rubyweb.rb <port>

require 'socket'
require 'logger'

# port 80 is the default
port = ARGV.length == 0 ? 80 : ARGV[0]

# create TCP server
server = TCPServer.new port

# create logger
logger = Logger.new(STDOUT)
logger.info("Starting server on part #{port}")

# loop waiting for client requests
while session = server.accept
    # get client ip address
    sock_domain, remote_port, remote_hostname, remote_ip = session.peeraddr

    # get client request
    request = session.recvmsg[0].split("\r\n")
    logger.info("request from #{remote_ip} is: #{request}")

    # just returns client ip address to the client
    session.print "HTTP/1.1 200\r\n"
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"
    session.print "#{remote_ip}"

    session.close
end



