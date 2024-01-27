Class {
	#name : #CardAmount,
	#superclass : #Object,
	#instVars : [
		'cardClass',
		'chance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CardAmount class >> usingType: aCardClass amount: aChance [ 
	^ self new initializeUsingType: aCardClass withAmount: aChance
]

{ #category : #Information }
CardAmount >> amountOfCards [
	^ chance.
]

{ #category : #Information }
CardAmount >> cardClass [
	^ cardClass
]

{ #category : #Initialization }
CardAmount >> initializeUsingType: aCardClass withAmount: aChance [ 
	cardClass:= aCardClass.
	chance:= aChance.
]
