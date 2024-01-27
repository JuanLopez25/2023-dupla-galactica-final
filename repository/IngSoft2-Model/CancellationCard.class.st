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

{ #category : #Information }
CancellationCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
CancellationCard >> applyCardUsing: cardManager at: aGame [

	cardManager desactivate: target
]

{ #category : #Information }
CancellationCard >> haveEffect [

	^ true
]

{ #category : #Information }
CancellationCard >> holder [

	^ holder
]

{ #category : #Information }
CancellationCard >> holder: aNewHolder [

	holder:= aNewHolder
]

{ #category : #Initialization }
CancellationCard >> initializeCreate [
	holder:= EmptyPlayer new.
	target:= EmptyPlayer new.
]

{ #category : #Information }
CancellationCard >> isEmpty [
	^false.
]

{ #category : #Information }
CancellationCard >> isPermanent [

	^ false
]

{ #category : #Information }
CancellationCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
