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

	target isEmpty ifTrue: [ 
		Error signal:
			'The objective has not been specify' ].
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
CancellationCard >> newHolder: aNewHolder [

	holder:= aNewHolder
]

{ #category : #Information }
CancellationCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
