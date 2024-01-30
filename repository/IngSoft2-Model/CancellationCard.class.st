Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
CancellationCard class >> create [
	^self new initializeCreate.
]

{ #category : #effect }
CancellationCard >> applyCardUsing: cardManager at: aGame to: anObjectiveCard [

	cardManager desactivate: anObjectiveCard.
	cardManager discard: self.
]

{ #category : #information }
CancellationCard >> hasEffect [

	^ true
]

{ #category : #information }
CancellationCard >> holder [

	^ holder
]

{ #category : #initialization }
CancellationCard >> initializeCreate [

	holder := EmptyObject new.
	target := EmptyObject new
]

{ #category : #information }
CancellationCard >> isEmpty [

	^ false
]

{ #category : #information }
CancellationCard >> isPermanent [

	^ false
]

{ #category : #information }
CancellationCard >> newHolder: aNewHolder [

	holder:= aNewHolder
]
