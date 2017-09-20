// -----------------------------------------------------------------------
/// \brief Calcule un terme de contrainte a partir d'une homographie.
///
/// \param H: matrice 3*3 définissant l'homographie.
/// \param i: premiere colonne.
/// \param j: deuxieme colonne.
/// \return vecteur definissant le terme de contrainte.
// -----------------------------------------------------------------------
function v = ZhangConstraintTerm(H, i, j)
 h1 = H(1,i,:)*H(1,j,:);
 h2 = H(1,i,:)*H(2,j,:) + H(2,i,:)*H(1,j,:);
 h3 = H(2,i,:)*H(2,j,:);
 h4 = H(3,i,:)*H(1,j,:) + H(1,i,:)*H(3,j,:);
 h5 = H(3,i,:)*H(2,j,:) + H(2,i,:)*H(3,j,:);
 h6 = H(3,i,:)*H(3,j,:);
 v = [h1,h2,h3,h4,h5,h6];
endfunction

// -----------------------------------------------------------------------
/// \brief Calcule deux equations de contrainte a partir d'une homographie
///
/// \param H: matrice 3*3 définissant l'homographie.
/// \return matrice 2*6 definissant les deux contraintes.
// -----------------------------------------------------------------------
function v = ZhangConstraints(H)
  v = [ZhangConstraintTerm(H, 1, 2); ...
    ZhangConstraintTerm(H, 1, 1) - ZhangConstraintTerm(H, 2, 2)];
endfunction

// -----------------------------------------------------------------------
/// \brief Calcule la matrice des parametres intrinseques.
///
/// \param b: vecteur resultant de l'optimisation de Zhang.
/// \return matrice 3*3 des parametres intrinseques.
// -----------------------------------------------------------------------
function A = IntrinsicMatrix(b)
  // A modifier!
  A = rand(3, 3);
endfunction

// -----------------------------------------------------------------------
/// \brief Calcule la matrice des parametres extrinseques.
///
/// \param iA: inverse de la matrice intrinseque.
/// \param H: matrice 3*3 definissant l'homographie.
/// \return matrice 3*4 des parametres extrinseques.
// -----------------------------------------------------------------------
function E = ExtrinsicMatrix(iA, H)
  // A modifier!
  E = rand(3, 4);
endfunction

