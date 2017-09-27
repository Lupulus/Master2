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
  Vo = ( b(2)*b(4) - b(1)*b(5) ) / (b(1)*b(3) -b(2)*b(2));
  lambda = b(6) - ( b(4)*b(4) + Vo*(b(2)*b(4) - b(1)*b(5)) ) / b(1);
  alpha = sqrt(lambda / b(1));
  beta = sqrt(lambda*b(1) / (b(1)*b(3) - b(2)*b(2) ) );
  gamma = - b(2)*alpha*alpha*beta / lambda;
  Uo = gamma*Vo/beta - b(4)*alpha*alpha/lambda;
  A = [alpha, gamma, Uo;
        0,    beta,  Vo;
        0,      0,    1];
endfunction

// -----------------------------------------------------------------------
/// \brief Calcule la matrice des parametres extrinseques.
///
/// \param iA: inverse de la matrice intrinseque.
/// \param H: matrice 3*3 definissant l'homographie.
/// \return matrice 3*4 des parametres extrinseques.
// -----------------------------------------------------------------------
function E = ExtrinsicMatrix(iA, H)
    h1 = H(:,1);
    lambda = 1 / norm((iA * h1));

    r1 = lambda * iA * h1;
    r2 = lambda * iA * H(:,2);
    r3 = cross(r1, r2);
    t  = lambda * iA * H(:,3);

    E = [r1, r2, r3, t];

endfunction

