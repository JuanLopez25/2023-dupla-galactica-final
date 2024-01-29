Class {
	#name : #DiceShaker,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
DiceShaker class >> withDie: aDie [ 
	^self new initializeWithDie: aDie.
]

{ #category : #dice }
DiceShaker >> addDie: aDie [

	dice addLast: aDie
]

{ #category : #initialization }
DiceShaker >> initializeWithDie: aDie [

	dice := OrderedCollection with: aDie
]

{ #category : #dice }
DiceShaker >> throwDice [

	^ dice sumNumbers: [ :die | die throw ]
]
