<?php 
	session_start();
?>
<?php
	try
	{
		$bdd = new PDO('pgsql:host=localhost;dbname=parkingProject', 'admin', 'admin');
	}
	catch (Exception $e)
	{
        die('Erreur : ' . $e->getMessage());
	}		
	$immat = $_POST['immatriculation'];
	$datefab = $_POST['dateFabrication'];
	$marque = $_POST['marque'];
	$typeVeh = $_POST['typeVehicule'];
	$id = $_SESSION['membreid'];
	if($immat != NULL){
		$reponse = $bdd->query("UPDATE vehicule SET immatriculation = '$immat' WHERE proprietaire = '$id'");
	}
	if($datefab != NULL){
		$reponse = $bdd->query("UPDATE vehicule SET date_fabrication = '$datefab' WHERE proprietaire = '$id'");
	}
	if($marque != NULL){
		$reponse = $bdd->query("UPDATE vehicule SET marque = '$marque' WHERE proprietaire = '$id'");
	}
	if($typeVeh != NULL){
		$reponse = $bdd->query("UPDATE vehicule SET type_veh = '$typeVeh' WHERE proprietaire = '$id'");
	}		
	header("Location: client.php");
	$reponse->closeCursor();
	exit;
?>
	