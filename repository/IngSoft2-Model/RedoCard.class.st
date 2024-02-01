Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'redoing'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> create [
	
	^self new initializeCreate.
]

{ #category : #comparing }
RedoCard >> = aCard [

	^ aCard isKindOf: self class
]

{ #category : #initialization }
RedoCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	cardManager lastCardPlay isEmpty ifFalse: [ 
		cardManager lastCardPlay
			applyCardUsing: cardManager
			at: aGame
			to: anObjective ]
]

{ #category : #card }
RedoCard >> effect [

	^ redoing effect
]

{ #category : #information }
RedoCard >> hasEffect [

	^ false
]

{ #category : #initialization }
RedoCard >> initializeCreate [
	
	redoing := EmptyObject new.
]

{ #category : #information }
RedoCard >> isEmpty [

	^ false
]

{ #category : #information }
RedoCard >> isPermanent [

	^ false
]

{ #category : #initialization }
RedoCard >> objectiveWhenTarget: anObjective using: aCardManager [

	redoing := aCardManager lastCardPlay.
	^ aCardManager lastCardPlay objectiveWhenTarget: anObjective using: aCardManager
]
