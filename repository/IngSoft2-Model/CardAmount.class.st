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

{ #category : #information }
CardAmount >> amountOfCards [

	^ chance
]

{ #category : #information }
CardAmount >> cardClass [

	^ cardClass
]

{ #category : #initialization }
CardAmount >> initializeUsingType: aCardClass withAmount: aChance [

	cardClass := aCardClass.
	chance := aChance
]
