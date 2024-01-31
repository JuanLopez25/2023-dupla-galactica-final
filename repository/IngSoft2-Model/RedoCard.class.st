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

	^ aCard class = self class
]

{ #category : #initialization }
RedoCard >> applyCardUsing: cardManager at: aGame to: anObjective [

	cardManager lastCardPlay isEmpty
		ifFalse: [ 
		redoing:= cardManager lastCardPlay.
		^ redoing applyCardUsing: cardManager at: aGame to: anObjective ]
		ifTrue: [ 
			Error signal:
				'Redo card cannot be played because there are no cards that have been played before' ]
]

{ #category : #card }
RedoCard >> applyEffect [

	(redoing isEmpty not and: [ redoing isPermanent ]) ifTrue: [ 
		^ redoing applyEffect ].
	Error signal: 'No card to imitate has been set'
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
