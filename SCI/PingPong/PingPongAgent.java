package PingPongAgent;

import jade.core.*;
import jade.core.behaviours.*;
import jade.lang.acl.ACLMessage;
import jade.domain.FIPAAgentManagement.ServiceDescription;
import jade.domain.FIPAAgentManagement.DFAgentDescription;
import jade.domain.DFService;
import jade.domain.FIPAException;
import jade.util.Logger;

public class PingPongAgent extends Agent {
  private Logger myLogger = Logger.getMyLogger(getClass().getName());

  public void action(){
    ACLMessage msg = myAgent.receive();
    if(msg.equals("Ping") || msg.equals("ping")){
      ACLMessage reply = msg.createReply();
      reply.setContent("Pong");
      send(reply);
    }

  }

  public void setup(){
    
  }
}
