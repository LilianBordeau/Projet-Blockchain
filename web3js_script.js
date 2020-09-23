var web3     = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

var contract_address ;
var public_key ;
var username ;
var contract ;

var nb_members;
var nb_attended_members;

var from_params;
/*
web3.eth.getAccounts().then(function(result){
  web3.eth.defaultAccount = result[0];
  //$.merge(accounts,result);
  //result.forEach(function(item){
    //console.log(item);
  //  accounts.push(item);
  //});
});
*/

/*  const get_nb_candidats = async (web3, account) => {

  const balance = await contract.methods.candidatesCount().call();

  return balance;
};*/

var res ;

//  web3.eth.candidatesCount().call().then(function(resp) {
//   alert(resp); // This will output "OK Computer"
// });
/*
$("#button").click(function(){
 console.log($("#name").val());
 contract.methods.addCandidate($("#name").val()).send({from:web3.eth.defaultAccount});
 alert('Candidat ' + $("#name").val() + ' ajouté.');
});

var nb_candidats ;

contract.methods.candidatesCount().call().then(function(result) {
 nb_candidats = result;
});
*/

$("#button_connexion").click(function(){
  public_key         = $("#publickey").val();
  username           = $("#username").val();
  contract_address   = $("#contract_address").val();

  var balance ;
  web3.eth.getBalance(public_key).then(function(result) {
   balance = result;
   console.log(balance);
  });

  web3.eth.defaultAccount = public_key;
  from_params = {from:web3.eth.defaultAccount, gas:3000000};

  contract = new web3.eth.Contract(messageABI, contract_address);

  contract.methods.addMember(username).send(from_params)
  .then(function(receipt){
    console.log(receipt);
});

  contract.methods.membersCount().call(from_params).then(function(result) {
   nb_members = result;
   $("#nb_members_connected").text(nb_members);
  });

  contract.methods.getAttendedMembers().call(from_params).then(function(result) {
   nb_attended_members = result;
   $("#nb_members_attended").text(nb_attended_members);
  });

  contract.methods.getMembersList().call(from_params).then(function(result) {
   console.log(result);

   $.each(result, function( index, value ) {
      var member_view = `<div class='input-group mb-3'>
        <div class='input-group-prepend'>
          <span class='input-group-text' id='basic-addon1'>👑`+value+`</span>
        </div>
        <input id='username' type='text' class='form-control' placeholder='0x85ADb0f8D629F299E7F926AF885A083d49849B6B' aria-label='Username' aria-describedby='basic-addon1'>
      </div>`;
      $(member_view).insertBefore( "#button_polling_space" );
    });

    console.log(nb_members, nb_attended_members);

    if(nb_members >= nb_attended_members)
     {
       $("#button_polling_space").prop('disabled', false);
     }

  });

  $("#connexion").hide();
  $("#waiting_room").show();
});

/*
$("#button_nb_candidats").click(function(){
  console.log(nb_candidats);
  alert("Il y a "+nb_candidats+" candidats inscrits.");
  contract.methods.candidatesCount().call().then(function(result) {
   nb_candidats = result;
  });
});

  var candidat;
  contract.methods.candidates(1).call().then(function(result) {
   candidat = result;
  });

$("#button_afficher_candidats").click(function(){
  console.log(candidat);
  alert("Id: " + candidat['id'] + "\nNom: " + candidat['name'] + "\nNombre de votes: " + candidat['voteCount']);
});

var proprio;
contract.methods.owner().call().then(function(result) {
 proprio = result;
});

$("#button_print_proprio").click(function(){
  alert(proprio);
});
*/
